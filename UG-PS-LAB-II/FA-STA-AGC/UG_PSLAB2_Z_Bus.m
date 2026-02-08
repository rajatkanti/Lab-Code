%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program is for Experiment No-5, Power System Lab-II of B.Tech. (EE)
% This demonstrates the implementation of Zbus algorithm.
% Source: https://gist.github.com/swanav/1b42678f32eaf340849f89254d853549
% Modified by: Rajat Kanti Samal, Dept. of Electrical Engg, VSSUT Burla
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function zBus = UG_PSLAB2_Z_Bus()

    % Reads a csv file storing line data
    % line sending_node receiving_node line_impedance
    lineData = csvread('Z_Bus_Line_Data.csv', 1, 0);

    % Find the number of lines and nodes in the imported line data
    lines = length(lineData(:, 1));
    nodes = max(max(lineData(:, 2)), max(lineData(:, 3)));

    % Initialize a Z Bus matrix of dimensions (nodes X nodes)
    zBus = zeros(nodes);

    % Initialize a array to store the scanned nodes (will contain old
    % nodes)
    scannedNodes = zeros(1, nodes);
    scannedIndex = 0;

    % Iterate over the rows of the line data
    for m = 1:lines
        nodes = lineData(m, 2:3);
        type = scanNodes(nodes);
        impedance = lineData(m, 4);
        switch(type)
            case 1
                % Type 1 Addition
                k = scannedNodes(scannedIndex);
                zBus(k, k) = impedance;
            case 2
                % Type 2 Addition
                k = scannedNodes(scannedIndex);
                if nodes(1) == k
                    j = nodes(2);
                else
                    j = nodes(1);
                end

                for i = 1:k-1
                    zBus(k, i) = zBus(j, i);
                    zBus(i, k) = zBus(i, j);
                end
                zBus(k, k) = zBus(j, j) + impedance;
            case 3
                % Type 3 Addition
                j = max(nodes);
                zBus = zBus - zBus(:, j)*...
                              (zBus(j, j) + impedance)^-1*...
                              zBus(j, :);
            case 4
                % Type 4 Addition
                i = nodes(1);
                j = nodes(2);
                zBus = zBus - (zBus(:,i)-zBus(:,j))*...
                              (zBus(i,i) + zBus(j,j) - zBus(i,j) - zBus(j,i) + impedance)^-1*...
                              (zBus(i,:)-zBus(j,:));
        end
    end

    function type = scanNodes(nodes)
        % Determines the type of addition to perform
        % parameter 'nodes' contains both nodes as [1 2]
        if searchFor(0, nodes)
           % One of the nodes is the reference node
           % Type 1 or Type 3 addition
           node = max(nodes);               % Search for the other node
           if searchFor(node, scannedNodes)
               % The other node is already scanned (Old Node and Reference Node)
               type = 3;
           else
               % The other node is new (New Node and Reference Node)
               type = 1;
               pushNode(node);
           end
        else
           % None of the nodes is the reference node
           % Type 2 or Type 4
           if searchFor(nodes(1), scannedNodes) && searchFor(nodes(2), scannedNodes)
               % Both the nodes are scanned (Old Node and Old Node)
               type = 4;
           else
               % One of the nodes is new (New node and Old Node)
               type = 2;
               if searchFor(nodes(1), scannedNodes)
                 pushNode(nodes(2))
               else
                 pushNode(nodes(1))
               end
           end
        end
    end

    function pushNode(node)
        % Stores the 'node' in scanned nodes array
       scannedIndex = scannedIndex + 1;
       scannedNodes(scannedIndex) = node;
    end

end


function isPresent = searchFor(element, matrix)
    % Read as "Search for 'element' in 'matrix'"
    % Searches for an element in an array or matrix
    dimensions = size(matrix);
    l = dimensions(1,1);
    b = dimensions(1,2);
    isPresent = false;
    for i = 1:l
       for j = 1:b
           if element == matrix(i,j)
              isPresent = true;
              return
           end
       end
    end
end

// Single-Diode Model of a Solar Panel
// Contributed by Mr Jaspreet Singh,  Sardar Vallabhbhai National Institute of Technology , Surat
// Source: https://scilab.in/case-study-project/case-study-run/87
// List: https://scilab.in/case-study-project/completed-case-studies
// Adapted for Power System Lab-II, B.Tech. (EE), 6th Semester
// Modified by Dr. Rajat Kanti Samal, Department of Electrical Engineering
// Veer Surendra Sai University of Technology Burla, Odisha, India

function I = PV_current(V, G, T, Rs, Rsh)
    Isc = 5.0;
    Tref = 298;
    Ki = 0.001;
    I0 = 1e-10;
    Gn = 1000;
    q = 1.6e-19;
    k = 1.38e-23;
    n = 1.3;
    
    Iph = (Isc + Ki * (T - Tref)) * (G / Gn);
    
    // Initial guess for current
    I = Iph;
    Vt = n * k * T / q;
    
    // Newton-Raphson Iteration to solve for I
    for iter = 1:20
        f = Iph - I - I0 * (exp((V + I * Rs) / Vt) - 1) - ((V + I * Rs) / Rsh);
        df = -1 - (I0 * exp((V + I * Rs) / Vt) * Rs / Vt) - (Rs / Rsh);
        I_new = I + f / df;
        
        I_new = max(I_new, 0);
        if abs(I_new - I) < 1e-6 then
            break;
        end
        I = I_new;
    end
    if V > 40 then
        I = 0;
    end
endfunction

// Voltage Range
V = linspace(0, 40, 100);

// Ask user for the dependency type
disp("Choose dependency to analyze:\n");
disp("1 - Irradiance dependency");
disp("2 - Temperature dependency");
disp("3 - Series resistance (Rs) dependency");
disp("4 - Shunt resistance (Rsh) dependency");
disp("5 - Efficiency vs Irradiance plot at Different Cell Resistances");
disp("6 - Efficiency vs Cell Temperature at Different Irradiance ");
disp("7 - Efficiency vs Irradiance at Different Series Resistances");
disp("8 - Efficiency vs Cell Temperature at Different Series Resistances");
disp("9 - Efficiency vs Incident Global at Different Shunt Resistances");
disp("10 - Efficiency vs Cell Temperature at Different Shunt Resistances");
choice = input("Enter your choice (1-10): ");

//1- *Irradiance Dependency*

if choice == 1 then
    G_values = [1000, 2000, 3000, 4000];
    colors = ["c", "b", "g", "r"];
    T = 318; // 45°C
    Rs = 0.02;
    Rsh = 100;

    scf(1);
    clf();
    xlabel("Voltage (V)");
    ylabel("Current (A)");
    title("I-V Characteristics for Different Irradiances");

    for i = 1:length(G_values)
        G = G_values(i);
        I = zeros(size(V));
        for j = 1:length(V)
            I(j) = PV_current(V(j), G, T, Rs, Rsh);
        end
        plot(V, I, colors(i), "LineWidth", 2);
    end
    legend("1000 W/m²", "2000 W/m²", "3000 W/m²", "4000 W/m²",pos=5);

    scf(2);
    clf();
    xlabel("Voltage (V)");
    ylabel("Power (W)");
    title("P-V Characteristics for Different Irradiances");

    for i = 1:length(G_values)
        G = G_values(i);
        P = zeros(size(V));
        for j = 1:length(V)
            I = PV_current(V(j), G, T, Rs, Rsh);
            P(j) = V(j) * I;
        end
        
        // Find Maximum Power Point (MPP)
        [Pmp, idx] = max(P);
        Vmp = V(idx);
        
        plot(V, P, colors(i), "LineWidth", 2);

        plot(Vmp, Pmp, "ko", "MarkerSize", 5); // Mark MPP with red dot
        xstring(Vmp, Pmp, msprintf(" Vmp=%.2fV, Pmp=%.2fW", Vmp, Pmp));
    end


//2- *Temperature Dependency*

elseif choice == 2 then
    Temps = [273, 298, 323];
    colors_temp = ["r", "g", "b"];
    Rs = 0.02;
    Rsh = 100;
    
    scf(3);
    clf();
    subplot(2,1,1);
    xlabel("Voltage (V)");
    ylabel("Current (A)");
    title("I-V Characteristics for Different Temperatures");

    for i = 1:length(Temps)
        T = Temps(i);
        I = zeros(size(V));
        for j = 1:length(V)
            I(j) = PV_current(V(j), 1000, T, Rs, Rsh);
        end
        plot(V, I, colors_temp(i), "LineWidth", 2);
    end
    legend("0°C", "25°C", "50°C",pos=5);

    subplot(2,1,2);
    xlabel("Voltage (V)");
    ylabel("Power (W)");
    title("P-V Characteristics for Different Temperatures");

    for i = 1:length(Temps)
        T = Temps(i);
        P = zeros(size(V));
        for j = 1:length(V)
            I = PV_current(V(j), 1000, T, Rs, Rsh);
            P(j) = V(j) * I;
        end
        
        // Find MPP
        [Pmp, idx] = max(P);
        Vmp = V(idx);
        
        plot(V, P, colors_temp(i), "LineWidth", 2);
        plot(Vmp, Pmp, "ro", "MarkerSize", 5);
        xstring(Vmp, Pmp, msprintf(" Vmp=%.2fV, Pmp=%.2fW", Vmp, Pmp));
    end
 

//  3- *Series Resistance (Rs) Dependency*

elseif choice == 3 then
    Rs_values = [ 0.4, 0.6, 0.8,1.0];
    colors_Rs = [ "g", "b", "m","c"];
    T = 313;
    G = 1000;
    Rsh = 400;
      scf(4);
    clf();
    subplot(2,1,1);
    xlabel("Voltage (V)");
    ylabel("Current (I)");
    title("I-V Characteristics for Different Rs Values");

    for i = 1:length(Rs_values)
        Rs = Rs_values(i);
        I = zeros(size(V));
        for j = 1:length(V)
            I(j) = PV_current(V(j), G, T, Rs, Rsh);
        end
        plot(V,I,colors_Rs(i),"Linewidth",2);
        xgrid()
    end
    legend("Rs=0.2 ohm","Rs=0.4 ohm","Rs=0.6 ohm","Rs=0.8 ohm","Rs=1.0 ohm",pos=5);
    
   
    
    subplot(2,1,2);
    xlabel("Voltage (V)");
    ylabel("Power (W)");
    title("P-V Characteristics for Different Rs Values");

    for i = 1:length(Rs_values)
        Rs = Rs_values(i);
        P = zeros(size(V));
        for j = 1:length(V)
            I = PV_current(V(j), G, T, Rs, Rsh);
            P(j) = V(j) * I;
        end
        
        [Pmp, idx] = max(P);
        Vmp = V(idx);
        
        plot(V, P, colors_Rs(i), "LineWidth", 2);
        xgrid();
        plot(Vmp, Pmp, "ko", "MarkerSize", 5);
        xstring(Vmp+5, Pmp-5, msprintf(" Vmp=%.2fV, Pmp=%.2fW", Vmp, Pmp));
    end
  
  
  
// 4-  Shunt resistance (Rsh) dependency"


elseif choice == 4 then
    Rs =0.389;
    colors_Rsh = [ "g", "b", "m","c"];
    T = 313;
    G = 1000;
    Rsh_values = [200,400,600,800];
      scf(5);
    clf();
    subplot(2,1,1);
    xlabel("Voltage (V)");
    ylabel("Current (I)");
    title("I-V Characteristics for Different Rsh Values");

    for i = 1:length(Rsh_values)
        Rsh = Rsh_values(i);
        I = zeros(size(V));
        for j = 1:length(V)
            I(j) = PV_current(V(j), G, T, Rs, Rsh);
        end
        plot(V,I,colors_Rsh(i),"Linewidth",2);
        xgrid()
    end
    legend("Rsh=200 ohm","Rsh=400 ohm","Rsh=600 ohm","Rsh=800 ohm",pos=5);
    
   
    
    subplot(2,1,2);
    xlabel("Voltage (V)");
    ylabel("Power (W)");
    title("P-V Characteristics for Different Rsh Values");

    for i = 1:length(Rsh_values)
        Rsh = Rsh_values(i);
        P = zeros(size(V));
        for j = 1:length(V)
            I = PV_current(V(j), G, T, Rs, Rsh);
            P(j) = V(j) * I;
        end
        
        [Pmp, idx] = max(P);
        Vmp = V(idx);
        
        plot(V, P, colors_Rsh(i), "LineWidth", 2);
        xgrid();
        plot(Vmp, Pmp, "ko", "MarkerSize", 5);
        xstring(Vmp+5, Pmp-7, msprintf(" Vmp=%.2fV, Pmp=%.2fW", Vmp, Pmp));
    end
    
    
     //5- New choice for Efficiency vs Incident Global at Different Cell Temperatures


   elseif choice == 5 then  
    Rs = 0.389; // Series resistance 
    Rsh = 1000; // Shunt resistance 
    G_values = [200, 400, 600, 800, 1000, 1200]; // Irradiance values (W/m^2)
    Temp_values = [273, 298, 323]; // Temperature values in Kelvin (0 deg C, 25 deg C, 50 deg C)
    colors_temp = ["r", "g", "b"]; // Colors for different temperature curves
    area_of_panel = 1.6; // Panel area in m^2
    gamma = -0.005; // Temperature coefficient (K^-1)
    T_ref = 298; // Reference temperature (25 deg C)

    scf(6);
    clf();
    xlabel("Incident Global Irradiation (W/m^2)");
    ylabel("Efficiency at Pmax (%)");
    title("Efficiency at Pmax vs Irradiance (Different Temperatures)");
    xgrid();

    // Loop over different temperatures
    for i = 1:length(Temp_values)
        T = Temp_values(i); // Current temperature
        efficiencies = zeros(size(G_values));
        
        // For each irradiance, compute Pmax and efficiency
        for j = 1:length(G_values)
            G = G_values(j);
            P = zeros(size(V));
            
            // Calculate current and power for each voltage
            for k = 1:length(V)
                I = PV_current(V(k), G, T, Rs, Rsh);
                P(k) = V(k) * I;
            end
            
            [Pmp, idx] = max(P); // Find Maximum Power Point (Pmp)
            
            // Efficiency Calculation with Temperature Compensation
            efficiency = (Pmp / (G * area_of_panel)) * 100 * (1 + gamma * (T - T_ref));
            efficiencies(j) = efficiency;
        end

        // Plot efficiency vs irradiance for the current temperature
        plot(G_values, efficiencies, colors_temp(i), "LineWidth", 2);
    end

    legend("T=0°C", "T=25°C", "T=50°C", pos=5);



//6- Efficiency vs Cell Temperature at Different Incident Irradiances



   elseif choice == 6 then  
    Rs = 0.389;                             // Series resistance 
    Rsh = 1000; // Shunt resistance 
    G_values = [ 400,500, 600, 800, 1000]; // Incident irradiance values (W/m^2)
    Temp_values = linspace(273, 373, 20);  // Temperature range from 0 degC to 100 degC (in Kelvin)
    area_of_panel = 1.6;                  // Panel area in m^2
    gamma = -0.005;                       // Temperature coefficient (K^-1)
    T_ref = 298;                          // Reference temperature (25 degC)
    colors_G = ["r", "g", "b", "m", "c"]; // Colors for different irradiances

    scf(7);
    clf();
    xlabel("Cell Temperature (K)");
    ylabel("Efficiency at Pmax (%)");
    title("Efficiency at Pmax vs Cell Temperature (Different Irradiances)");
    xgrid();

    // Loop over different incident irradiances
    for i = 1:length(G_values)
        G = G_values(i);                  // Current irradiance
        efficiencies = zeros(size(Temp_values));
        
        // For each temperature, compute Pmax and efficiency
        for j = 1:length(Temp_values)
            T = Temp_values(j);           // Current temperature
            P = zeros(size(V));
            
            // Calculate current and power for each voltage
            for k = 1:length(V)
                I = PV_current(V(k), G, T, Rs, Rsh);
                P(k) = V(k) * I;
            end
            
            [Pmp, idx] = max(P);          // Find Maximum Power Point (Pmp)
            
            // Efficiency Calculation with Temperature Compensation
            efficiency = (Pmp / (G * area_of_panel)) * 100 * (1 + gamma * (T - T_ref));
            efficiencies(j) = efficiency;
        end

        // Plot efficiency vs temperature for the current irradiance
        plot(Temp_values, efficiencies, colors_G(i), "LineWidth", 2);
    end

    
    legend("G=200 W/m²", "G=400 W/m²", "G=600 W/m²", "G=800 W/m²", "G=1000 W/m²", pos=5);



        //7- Efficiency vs Incident Global at Different Series Resistances



      elseif choice == 7 then  
    Rsh = 400;                             // Shunt resistance 
    Rs_values = [0.1, 0.2, 0.4, 0.8];       // Series resistance values 
    G_values = linspace(200, 1200, 20);     // Irradiance range from 200 to 1200 W/m^2
    T = 313;                                // Constant cell temperature 40 deg C
    area_of_panel = 1.6;                   // Panel area in m^2
    gamma = -0.005;                        // Temperature coefficient (K^-1)
    T_ref = 298;                           // Reference temperature (25 deg C)
    colors_Rs = ["r", "g", "b", "m"];      // Colors for different series resistances

    scf(8);
    clf();
    xlabel("Incident Global Irradiation (W/m^2)");
    ylabel("Efficiency at Pmax (%)");
    title("Efficiency at Pmax vs Irradiance (Different Rs)");
    xgrid();

    // Loop over different series resistances
    for i = 1:length(Rs_values)
        Rs = Rs_values(i);                  // Current series resistance
        efficiencies = zeros(size(G_values));
        
        // For each irradiance, compute Pmax and efficiency
        for j = 1:length(G_values)
            G = G_values(j);                 // Current irradiance
            P = zeros(size(V));
            
            // Calculate current and power for each voltage
            for k = 1:length(V)
                I = PV_current(V(k), G, T, Rs, Rsh);
                P(k) = V(k) * I;
            end
            
            [Pmp, idx] = max(P);            // Find Maximum Power Point (Pmp)
            
            // Efficiency Calculation with Temperature Compensation
            efficiency = (Pmp / (G * area_of_panel)) * 100 * (1 + gamma * (T - T_ref));
            efficiencies(j) = efficiency;
        end

        // Plot efficiency vs irradiance for the current series resistance
        plot(G_values, efficiencies, colors_Rs(i), "LineWidth", 2);
    end

   
    legend("Rs=0.1 ohm", "Rs=0.2 ohm", "Rs=0.4 ohm", "Rs=0.8 ohm", pos=5);



    //8-  Efficiency vs Cell Temperature at Different Series Resistances
        
        
        
    elseif choice == 8 then  
    Rsh = 400; // Shunt resistance  
    Rs_values = [  0.4, 0.6, 0.8, 1.0]; // Series resistance values 
    Temp_values = linspace(273, 373, 20); // Temperature range from 0 deg C to 100 deg C (in Kelvin)
    G = 1000; 
    area_of_panel = 1.6; // Panel area in m^2
    gamma = -0.005; // Temperature coefficient (K^-1)
    T_ref = 298; // Reference temperature (25 degC)
    colors_Rs = ["r", "g", "b", "m"]; 

    scf(9);
    clf();
    xlabel("Cell Temperature (K)");
    ylabel("Efficiency at Pmax (%)");
    title("Efficiency at Pmax vs Cell Temperature (Different Rs)");
    xgrid();

    // Loop over different series resistances
    for i = 1:length(Rs_values)
        Rs = Rs_values(i); // Current series resistance
        efficiencies = zeros(size(Temp_values));
        
        // For each temperature, compute Pmax and efficiency
        for j = 1:length(Temp_values)
            T = Temp_values(j); // Current temperature
            P = zeros(size(V));
            
            // Calculate current and power for each voltage
            for k = 1:length(V)
                I = PV_current(V(k), G, T, Rs, Rsh);
                P(k) = V(k) * I;
            end
            
            [Pmp, idx] = max(P); // Find Maximum Power Point (Pmp)
            
            // Efficiency Calculation with Temperature Compensation
            efficiency = (Pmp / (G * area_of_panel)) * 100 * (1 + gamma * (T - T_ref));
            efficiencies(j) = efficiency;
        end

        // Plot efficiency vs temperature for the current series resistance
        plot(Temp_values, efficiencies, colors_Rs(i), "LineWidth", 2);
    end
    
    legend("Rs=0.2ohm", "Rs=0.4 ohm", "Rs=0.6 ohm", "Rs=0.8 ohm", pos=5);



    //9- New choice for Efficiency vs Irradiance plot at Different Shunt resistance



elseif choice == 9 then  
    Rs = 0.389; 
    Rsh_values = [200, 400, 600, 800];            // Different Shunt resistance values
    G_values = [200, 400, 600, 800, 1000, 1200];  // Irradiance values
    colors_eff = ["r", "g", "b", "m"]; 
    T = 313;                                     // (40 deg C)
    area_of_panel = 1.6;                         // Panel area in m^2
    gamma = -0.005;                              // Temperature coefficient (K^-1)
    T_ref = 298;                                 // Reference temperature (25 deg C)

    scf(10);
    clf();
    xlabel("Incident Global Irradiation (W/m²)");
    ylabel("Efficiency at Pmax (%)");
    title("Efficiency at Pmax vs Irradiance (Different Rsh)");
    xgrid();

    for i = 1:length(Rsh_values)
        Rsh = Rsh_values(i);
        efficiencies = zeros(size(G_values));
        
        for j = 1:length(G_values)
            G = G_values(j);
            P = zeros(size(V));
            
            for k = 1:length(V)  
                I = PV_current(V(k), G, T, Rs, Rsh);
                P(k) = V(k) * I;
            end
            
            [Pmp, idx] = max(P);             // Find Maximum Power
            
            // Efficiency Calculation with Temperature Compensation
            efficiency = (Pmp / (G * area_of_panel)) * 100 * (1 + gamma * (T - T_ref));
            efficiencies(j) = efficiency;
        end

        plot(G_values, efficiencies, colors_eff(i), "LineWidth", 2);
    end
    legend("Rsh=200 ohm", "Rsh=400 ohm", "Rsh=600 ohm", "Rsh=800 ohm", pos=5);
    
    

   //10- New choice for Efficiency vs Cell Temperature at Different Shunt Resistances



elseif choice == 10 then  
    Rs = 0.389; // Series resistance 
    Rsh_values = [ 200, 400,500, 600]; // Shunt resistance values 
    Temp_values = linspace(273, 500, 20); // Temperature range from 0 degC to 100 degC (in Kelvin)
    G = 1000; 
    area_of_panel = 1.6; // Panel area in m^2
    gamma = -0.005; // Temperature coefficient (K^-1)
    T_ref = 298; // Reference temperature (25 degC)
    colors_Rsh = ["r", "g", "b", "m"]; // Colors for different shunt resistances

    scf(11);
    clf();
    xlabel("Cell Temperature (K)");
    ylabel("Efficiency at Pmax (%)");
    title("Efficiency at Pmax vs Cell Temperature (Different Rsh)");
    xgrid();

    // Loop over different shunt resistances
    for i = 1:length(Rsh_values)
        Rsh = Rsh_values(i); // Current shunt resistance
        efficiencies = zeros(size(Temp_values));
        
        // For each temperature, compute Pmax and efficiency
        for j = 1:length(Temp_values)
            T = Temp_values(j); // Current temperature
            P = zeros(size(V));
            
            // Calculate current and power for each voltage
            for k = 1:length(V)
                I = PV_current(V(k), G, T, Rs, Rsh);
                P(k) = V(k) * I;
            end
            
            [Pmp, idx] = max(P); // Find Maximum Power Point (Pmp)
            
            // Efficiency Calculation with Temperature Compensation
            efficiency = (Pmp / (G * area_of_panel)) * 100 * (1 + gamma * (T - T_ref));
            efficiencies(j) = efficiency;
        end

        // Plot efficiency vs temperature for the current shunt resistance
        plot(Temp_values, efficiencies, colors_Rsh(i), "LineWidth", 2);
        xgrid()
    end

    legend("Rsh=100", "Rsh=200", "Rsh=400", "Rsh=800", pos=5);
    
    else
    // Handle invalid input
    messagebox("Invalid choice! Please enter a number from 1 to 10.", "Error", "error");
    // You could also add code to ask for input again here if you want
end
    
    
       

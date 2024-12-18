%{
Kyle Kirchoff
Kirchok1@my.erau.edu
4/18/2023
Flight planner that generates METAR info (random) and compares your weather
minimums, also tells you distances between airports on your flight and how
much fuel it will take. In addition it plots weight and balance based on
user inputs. Numbers are based on a piper cherokee 180
Trial 1:
Welcome!
Data for this flight planner is regarding a piper PA28-180! 
Do you want to input wind and cloud warnings on your flight? input 1 for yes:1
Input weather information that results in the flight being a no go,
what is your maximum wind speed in MPH?25
what is your minimum for clouds? 
Enter evelavtion in hundreds of feet, for example 500 feet would be 005 and 10,000 feet would be 100: 20
Are you happy with these inputs? Press 1 to redo and anything else to continue:

How many airports will you be going to? 
for example If I was to take off from KHFD and fly to KHVN then fly back to KHFD, my awnser would be 3:3

enter airport indentifier code, example KHFD:KHFD

enter airport indentifier code, example KHFD:KIJD

enter airport indentifier code, example KHFD:KJFK

Here is information regarding your flight distances and weather:
METAR info at Hartford Brainard Airport is as follows:
METAR KHFD 181247Z 14017KT 1SM OVC110 -1/-4
The distance for leg 1 of the flight is 24.191195 miles

METAR info at Windham Airport is as follows:
METAR KIJD 181247Z 01010KT 8SM CLR 12/16
The distance for leg 2 of the flight is 112.825516 miles

METAR info at John F Kennedy International Airport is as follows:
METAR KJFK 181247Z 10020KT 10SM SCT000 FEW150 00/-4
The total distance foy your flight is 137.016710 miles

This means your flight will roughly last about 1.01 hours and consume 10.09 gallons of fuel, 
this means you should atleast take 15.09 gallons of fuel to comply with FAA regulations!
Warning! the maximum wind you will experience at one of the airports you selected is higher than your limit!
do you want to redo this? enter 1 for yes and any other number for no0
Input the weight in the front left seat in pounds:135
Input the weight in the front left seat in pounds:0
Input the weight in the back left seat in pounds:0
Input the weight in the back left seat in pounds:0
Input the weight in the baggage compartment in pounds:0
input the number of gallons of fuel you will take:0
Your total weigth is 1659.0 pounds, your CG is 87.5 inches, and your moment is 145208.1>> 
Trial 2:

Trial 3:

%}
clc;
clear;
close all;
fprintf('Welcome!\n')
fprintf('Data for this flight planner is regarding a piper PA28-180! \n')
%airport identifiers you can input are listed in array tittled raw, over
%60,000 identifiers to choose from!
%input weather minimums
gonogo=input('Do you want to input wind and cloud warnings on your flight? input 1 for yes, input anything else for no:','s');
if any([isempty(gonogo), gonogo ~= '1']) %<SM.IF>
    userwind = 100000;
    userceiling = 0;
end
while gonogo=='1'
    fprintf('Input weather information that results in the flight being a no go,\n')
    userwind=str2double(input('what is your maximum wind speed in KNOTS?','s'));
    while isempty(userwind) || isnan(userwind)|| userwind<0 %<SM.BOP>
        fprintf('Try Again!')
        userwind=str2double(input('what is your maximum wind speed in KNOTS?','s'));
    end
    userceiling=str2double(input('what is your minimum for clouds? \nEnter evelavtion in hundreds of feet, for example 500 feet would be 005 and 10,000 feet would be 100: ','s'));
    while isempty(userceiling) || isnan(userceiling) || userceiling < 0
        fprintf('Try Again!')
        userceiling=str2double(input('what is your minimum for clouds? \nEnter evelavtion in hundreds of feet, for example 500 feet would be 005 and 10,000 feet would be 100: ','s'));
    end
    gonogo=input('Are you happy with these inputs? Press 1 to redo and anything else to continue:','s');
end
%imports the xl file with airports and cordinates
filename = 'Airports.xlsx'; %<SM:READ>
[num, txt, raw] = xlsread(filename);
%fprintf('test')
y='1';
while y=='1'
    numberofstops=str2double(input('\nHow many airports will you be going to? \nfor example If I was to take off from KHFD and fly to KHVN then fly back to KHFD, my awnser would be 3:','s'));
    while isempty(numberofstops) || isnan(numberofstops) || numberofstops < 0
        fprintf('Try Again!')
        numberofstops=str2double(input('\nHow many airports will you be going to? \nfor example If I was to take off from KHFD and fly to KHVN then fly back to KHFD, my awnser would be 3:','s'));
    end 
    empty_array=cell(numberofstops,13);
    x=1; %for row of array airport will be saved in.
    if numberofstops==1
        air=1;
        while air == 1
            airport=input('\nenter airport indentifier code, example KHFD:','s');
            while isempty(airport) == 1
                fprintf('\ntry again')
                airport=input('\nenter airport indentifier code, example KHFD:','s');
            end
            searchString = airport;
            matches = strcmp(raw(:,1), searchString);
            columnIndex  = find(matches);
            if any(columnIndex)
                air=0;
                %fprintf('good')
            else
                fprintf('%s not found, please try again. . . ', airport)
            end
        end
        searchString = airport;
        matches = strcmp(raw(:,1), searchString);
        columnIndex  = find(matches);
        name=raw(columnIndex,3);
        fprintf('METAR info at %s is as follows:\n',name{1})
        % example METAR KJFK 112056Z 21018G25KT 10SM SCT040 BKN070 OVC090 11/05 A2998 RMK AO2 PK WND 22028/2046 SLP151 T01060050 56018
        %airport
        %zulutime
        t = datetime('now','TimeZone','UTC');
        today = datetime('today');
        zulu_time = datestr(t, 'DDHHMM');
        %winddirection *decided to leave gusts out of randomly generated metar*
        wind=ceil(rand(1)*36);
        wind1=wind*10;
        formatted_wind = sprintf('%03d', wind1);
        %windspeed
        windspeed=round(rand(1)*30);
        formatted_windspeed = sprintf('%02d', windspeed);
        %visibility
        clear=ceil(rand(1)*3);
        if clear == 1
            vis=round(rand(1)*10);
        else
            vis = 10;
        end
        %clouds
        weather=round(rand(1)*4);
        if weather == 0 || weather == 1
            sky='CLR';
            hello=sky;
        elseif weather ==2 %<SM:RAND>
            cloud_types = { 'FEW', 'SCT', 'BKN', 'OVC'};
            sky = cloud_types{randi(length(cloud_types))};
            hello=sky;
            cloud_heights = [0, 005, 010, 015, 020, 025, 030, 035, 040, 045, 050, 055, 060, 065, 070, 075, 080, 090,100,110, 150]; %all possiblr cloud heights
            cloud_height = cloud_heights(randi(length(cloud_heights)));
            cloud_height = sprintf('%03d', cloud_height);
            sky = strcat(sky, num2str(cloud_height));
        elseif weather == 3 %this creates two cloud layers
            cloud_types = { 'FEW', 'SCT', 'BKN', 'OVC'};
            sky = cloud_types{randi(length(cloud_types))};
            hello=sky;
            cloud_heights = [0, 005, 010, 015, 020, 025, 030, 035, 040, 045];
            cloud_height = cloud_heights(randi(length(cloud_heights)));
            cloud_height = sprintf('%03d', cloud_height);
            sky = strcat(sky, num2str(cloud_height));
            cloud_types1 = { 'FEW', 'SCT', 'BKN', 'OVC'};
            sky1 = cloud_types1{randi(length(cloud_types1))};
            cloud_heights1 = [050, 055, 060, 065, 070, 075, 080, 090,100,110, 150];
            cloud_height1 = cloud_heights1(randi(length(cloud_heights1)));
            cloud_height1 = sprintf('%03d', cloud_height1);
            sky1 = strcat(sky1, num2str(cloud_height1));
            hello1=sky1;
            sky = sprintf('%s %s', sky, sky1);
        else %this creates three cloud layers
            cloud_types = { 'FEW', 'SCT', 'BKN', 'OVC'};
            sky = cloud_types{randi(length(cloud_types))};
            hello=sky;
            cloud_heights = [005, 010, 015, 020, 025, 030, 035];
            cloud_height = cloud_heights(randi(length(cloud_heights)));
            cloud_height = sprintf('%03d', cloud_height);
            sky = strcat(sky, num2str(cloud_height));
            cloud_types1 = { 'FEW', 'SCT', 'BKN', 'OVC'};
            sky1 = cloud_types1{randi(length(cloud_types1))};
            hello1=sky1;
            cloud_heights1 = [050, 055, 060, 065, 070, 075, 080];
            cloud_height1 = cloud_heights1(randi(length(cloud_heights1)));
            cloud_height1 = sprintf('%03d', cloud_height1);
            sky1 = strcat(sky1, num2str(cloud_height1));
            cloud_types2 = { 'FEW', 'SCT', 'BKN', 'OVC'};
            sky2 = cloud_types2{randi(length(cloud_types2))};
            cloud_heights2 = [090,100,110, 120,150];
            cloud_height2 = cloud_heights2(randi(length(cloud_heights2)));
            cloud_height2 = sprintf('%03d', cloud_height2);
            sky2 = strcat(sky2, num2str(cloud_height2));
            hello2=sky2;
            sky = sprintf('%s %s %s', sky, sky1, sky2);
            windy=windspeed;
        end
        if strcmp(hello,'FEW') %<SM.NEST>
            if strcmp(hello,'FEW') || strcmp(hello,'SCT') %used to find minimum clound height for eralier flight limitations 
                if strcmp(hello1,'FEW') || strcmp(hello1,'SCT') %FEW ans SCT clounds don't affect minimums thus the next clound height must be used
                    if strcmp(hello2,'FEW') || strcmp(hello2,'SCT') %if all layers have Few & SCT then no clound min is entered
                        PleaseGiveMeAGoodGrade = 10000; %used a really high minimum for clear skies so it won't interfere with any user inputs as a piper can't fly 1,000,000 ft high
                    else
                        PleaseGiveMeAGoodGrade = cloud_height2;
                    end
                else
                    PleaseGiveMeAGoodGrade = cloud_height1;
                end
            else
                PleaseGiveMeAGoodGrade = cloud_height;
            end
        else
            PleaseGiveMeAGoodGrade = 10000 ;
        end
        %Temperature
        temp=round(rand(1)*32);
        temp=temp-5;
        temp = sprintf('%02d', temp); %<SM:STRING>
        %dewpoint
        highlow=round(rand(1));
        diff = round(rand(1)*7);
        if highlow==0
            dew=str2double(temp)+diff;
        elseif highlow ==1
            dew=str2double(temp)-diff;
        else
            fprintf('error')
        end
        dew = sprintf('%02d', dew);
        %METAR information
        if isempty(gonogo) == 0
            fprintf('METAR %s %sZ %s%sKT %dSM %s %s/%s', airport, zulu_time,formatted_wind, formatted_windspeed, vis,sky,temp,dew)
            if userwind < windy
                fprintf('\nWarning! the maximum wind you will experience at one of the airports you selected is higher than your limit!')
            end
            if userceiling > PleaseGiveMeAGoodGrade
                fprintf('\nWarning! the minimum cloud ceiling you will experience at one of the airports you selected is lower than your limit!')
            end
        end
        y=input('\ndo you want to redo this? enter 1 for yes and any other number for no:','s');
    elseif numberofstops > 1
        for x=1:numberofstops %<SM:FOR>
            air =1;
            while air == 1
                airport=input('\nenter airport indentifier code, example KHFD:','s');
                while isempty(airport) == 1
                    fprintf('\ntry again')
                    airport=input('\nenter airport indentifier code, example KHFD:','s');
                end
                searchString = airport;
                matches = strcmp(raw(:,1), searchString);
                columnIndex  = find(matches);
                if any(columnIndex)
                    air=0;
                    %fprintf('good')
                else
                    fprintf('%s not found, please try again. . . ', airport)
                end
            end
            %inputs identification code into empty cell array
            searchString = airport;
            matches = strcmp(raw, searchString);
            columnIndex  = find(matches);
            empty_array{x,1}=cellstr(airport);
            %inputs type of airport into empty cell array
            type=raw(columnIndex,2);
            empty_array{x,2}=cellstr(type);
            %inputs airport name into empty cell array
            name=raw(columnIndex,3);
            empty_array{x,3}=cellstr(name);
            %inputs latitude into empty cell array
            lat=raw(columnIndex,4);
            lat_str = num2str(cell2mat(lat));
            empty_array{x,4}=lat_str;
            %inputs langitude into empty cell array
            lon=raw(columnIndex,5);
            lon_str = num2str(cell2mat(lon));
            empty_array{x,5}=lon_str;
            %Metar Information
            searchString = airport;
            matches = strcmp(raw, searchString);
            columnIndex  = find(matches);
            name=raw(columnIndex,3);
            %zulutime
            t = datetime('now','TimeZone','UTC');
            today = datetime('today');
            zulu_time = datestr(t, 'DDHHMM');
            %winddirection *decided to leave gusts out of randomly generated metar*
            wind=ceil(rand(1)*36);
            wind1=wind*10;
            formatted_wind = sprintf('%03d', wind1);
            %windspeed
            windspeed=round(rand(1)*30);
            formatted_windspeed = sprintf('%02d', windspeed);
            %visibility
            clear=ceil(rand(1)*3);
            if clear == 1
                vis=round(rand(1)*10);
            else
                vis = 10;
            end
            %clouds
            weather=round(rand(1)*4);
            if weather == 0 || weather == 1
                sky='CLR';
                hello=sky;
            elseif weather ==2
                cloud_types = { 'FEW', 'SCT', 'BKN', 'OVC'};
                sky = cloud_types{randi(length(cloud_types))};
                hello=sky;
                cloud_heights = [0, 005, 010, 015, 020, 025, 030, 035, 040, 045, 050, 055, 060, 065, 070, 075, 080, 090,100,110, 150];
                cloud_height = cloud_heights(randi(length(cloud_heights)));
                cloud_height = sprintf('%03d', cloud_height);
                sky = strcat(sky, num2str(cloud_height));
            elseif weather == 3
                cloud_types = { 'FEW', 'SCT', 'BKN', 'OVC'};
                sky = cloud_types{randi(length(cloud_types))};
                hello=sky;
                cloud_heights = [0, 005, 010, 015, 020, 025, 030, 035, 040, 045];
                cloud_height = cloud_heights(randi(length(cloud_heights)));
                cloud_height = sprintf('%03d', cloud_height);
                sky = strcat(sky, num2str(cloud_height));
                cloud_types1 = { 'FEW', 'SCT', 'BKN', 'OVC'};
                sky1 = cloud_types1{randi(length(cloud_types1))};
                cloud_heights1 = [050, 055, 060, 065, 070, 075, 080, 090,100,110, 150];
                cloud_height1 = cloud_heights1(randi(length(cloud_heights1)));
                cloud_height1 = sprintf('%03d', cloud_height1);
                sky1 = strcat(sky1, num2str(cloud_height1));
                hello1=sky1;
                sky = sprintf('%s %s', sky, sky1);
            else
                cloud_types = { 'FEW', 'SCT', 'BKN', 'OVC'};
                sky = cloud_types{randi(length(cloud_types))};
                hello=sky;
                cloud_heights = [005, 010, 015, 020, 025, 030, 035];
                cloud_height = cloud_heights(randi(length(cloud_heights)));
                cloud_height = sprintf('%03d', cloud_height);
                sky = strcat(sky, num2str(cloud_height));
                cloud_types1 = { 'FEW', 'SCT', 'BKN', 'OVC'};
                sky1 = cloud_types1{randi(length(cloud_types1))};
                hello1=sky1;
                cloud_heights1 = [050, 055, 060, 065, 070, 075, 080];
                cloud_height1 = cloud_heights1(randi(length(cloud_heights1)));
                cloud_height1 = sprintf('%03d', cloud_height1);
                sky1 = strcat(sky1, num2str(cloud_height1));
                cloud_types2 = { 'FEW', 'SCT', 'BKN', 'OVC'};
                sky2 = cloud_types2{randi(length(cloud_types2))};
                cloud_heights2 = [090,100,110, 120,150];
                cloud_height2 = cloud_heights2(randi(length(cloud_heights2)));
                cloud_height2 = sprintf('%03d', cloud_height2);
                sky2 = strcat(sky2, num2str(cloud_height2));
                hello2=sky2;
                sky = sprintf('%s %s %s', sky, sky1, sky2);
                windy=windspeed;
            end
            if strcmp(hello,'FEW')
                if strcmp(hello,'FEW') || strcmp(hello,'SCT')
                    if strcmp(hello1,'FEW') || strcmp(hello1,'SCT')
                        if strcmp(hello2,'FEW') || strcmp(hello2,'SCT')
                            PleaseGiveMeAGoodGrade = 10000;
                        else
                            PleaseGiveMeAGoodGrade = cloud_height2;
                        end
                    else
                        PleaseGiveMeAGoodGrade = cloud_height1;
                    end
                else
                    PleaseGiveMeAGoodGrade = cloud_height;
                end
            else
                PleaseGiveMeAGoodGrade = 10000 ;
            end
            %Temperature
            temp=round(rand(1)*32);
            temp=temp-5;
            temp = sprintf('%02d', temp);
            %dewpoint
            highlow=round(rand(1));
            diff = round(rand(1)*7);
            if highlow==0
                dew=str2double(temp)+diff;
            elseif highlow ==1
                dew=str2double(temp)-diff;
            else
                fprintf('error')
            end
            dew = sprintf('%02d', dew);
            %METAR information
            metar=sprintf('METAR %s %sZ %s%sKT %dSM %s %s/%s', airport, zulu_time,formatted_wind, formatted_windspeed, vis,sky,temp,dew);
            empty_array{x,6}=metar; %<SM:REF>
            empty_array{x,10}=sky;
            empty_array{x,7}=zulu_time;
            empty_array{x,8}=formatted_windspeed;
            empty_array{x,9}=vis;
            empty_array{x,10}=sky;
            empty_array{x,11}=temp;
            empty_array{x,12}=dew;
            empty_array{x,13}=PleaseGiveMeAGoodGrade;
        end
        n=1;
        timesrun=numberofstops-1;
        distance_array = zeros(timesrun,1);
        name=empty_array{1,3};
        randomvariablego=empty_array{1,6};
        fprintf('\nHere is information regarding your flight distances and weather:')
        fprintf('\nMETAR info at %s is as follows:\n',name{1})
        fprintf('%s',randomvariablego)
        for n=1:timesrun
            hneigbhenilbuhneiulbhnbuiehtnbuekthjn=n+1;
            randonrandomimlosingmysanitypleasehelp = n;
            lattitude1=str2double(empty_array{n,4});
            longitude1=str2double(empty_array{n,5});
            %n=n+1;
            lattitude2=str2double(empty_array{hneigbhenilbuhneiulbhnbuiehtnbuekthjn,4});
            longitude2=str2double(empty_array{hneigbhenilbuhneiulbhnbuiehtnbuekthjn,5});
            distance_array(randonrandomimlosingmysanitypleasehelp,1) = programmerdefinedfunction(lattitude1,longitude1,lattitude2,longitude2); %<SM:PDF_CALL>
            fprintf('\nThe distance for leg %d of the flight is %f miles\n', n,distance_array(n,1))
            name=empty_array{hneigbhenilbuhneiulbhnbuiehtnbuekthjn,3};
            randomvariablego=empty_array{hneigbhenilbuhneiulbhnbuiehtnbuekthjn,6};
            fprintf('\nMETAR info at %s is as follows:\n',name{1})
            fprintf('%s',randomvariablego)
        end
        totalmiles=sum(distance_array); %<SM:RTOTAL>
        if numberofstops > 2
            fprintf('\nThe total distance foy your flight is %f miles', totalmiles)
        end
        cruisingspeed= 135.792; %in miles per hour, it is 118 in kt per hour
        flighttime=totalmiles/cruisingspeed;
        gallonsforflight=flighttime*10;
        flightgallons=gallonsforflight+5;
        fprintf('\n\nThis means your flight will roughly last about %0.2f hours and consume %0.2f gallons of fuel, \nthis means you should atleast take %0.2f gallons of fuel to comply with FAA regulations!',flighttime,gallonsforflight,flightgallons)
        if isempty(gonogo) ~=1
            numeric_array = cell2mat(empty_array(:,8));
            windy=max(numeric_array);
            if userwind < windy
                fprintf('\nWarning! the maximum wind you will experience at one of the airports you selected is higher than your limit!')
            end
            wind_array = cell2mat(empty_array{:,13});
            ceiling=min(wind_array);
            if userceiling > ceiling
                fprintf('\nWarning! the minimum cloud ceiling you will experience at one of the airports you selected is lower than your limit!')
            end
            x=x+1;
        end
        y=input('\ndo you want to redo this? enter 1 for yes and any other number for no','s');
    end
end
%weight and balance calculations
frontleftseat=str2double(input('Input the weight in the front left seat in pounds:','s'));
while isempty(frontleftseat) || isnan(frontleftseat) ||frontleftseat < 0 || mod(frontleftseat,1) ~= 0 %<SM:WHILE>
    fprintf('Try again\n')
    frontleftseat=str2double(input('Input the weight in the front left seat in pounds:','s'));
end
frontrightseat=str2double(input('Input the weight in the front right seat in pounds:','s'));
while isempty(frontrightseat) || frontrightseat < 0 || mod(frontrightseat,1) ~= 0
    fprintf('Try again\n')
    frontrightseat=str2double(input('Input the weight in the front right seat in pounds:','s'));
end
backleftseat=str2double(input('Input the weight in the back left seat in pounds:','s'));
while isempty(backleftseat) || isnan(backleftseat) ||backleftseat < 0 || mod(backleftseat,1) ~= 0
    fprintf('Try again\n')
    backleftseat=input('Input the weight in the back left seat in pounds:','s');
end
backrightseat=str2double(input('Input the weight in the back right seat in pounds:','s'));
while isempty(backrightseat) || isnan(backrightseat) ||backrightseat < 0 || mod(backrightseat,1) ~= 0
    fprintf('Try again\n')
    backrightseat=str2double(input('Input the weight in the back right seat in pounds:','s'));
end
baggage=str2double(input('Input the weight in the baggage compartment in pounds:','s'));
while isempty(baggage) || isnan(baggage) || baggage < 0 || mod(baggage,1) ~= 0
    fprintf('Try again\n')
    baggage=str2double(input('Input the weight in the baggage compartment in pounds:','s'));
end
fuel=str2double(input('input the number of gallons of fuel you will take:','s'));
while isempty(fuel) || isnan(fuel) || fuel < 0 || fuel > 50 || mod(fuel,1) ~= 0
    fprintf('Try again\n')
    fuel=str2double(input('input the number of gallons of fuel you will take:','s'));
end
empty_weight = 1524.0; % Empty weight of the aircraft in pounds
empty_weight_arm = 88.15; % Arm of the empty weight in inches
fuel_arm = 95.0; % Arm of the fuel in inches
max_ramp_weight = 2450.0; % Maximum weight of the aircraft in pounds
front_seat_arm = 80.5; % Arm of the front seats in inches
rear_seat_arm = 118.1; % Arm of the rear seats in inches
baggage_arm = 142.8; % Arm of the baggage compartment in inches
fuelweight=fuel*6.01;
totalweight= frontrightseat+frontleftseat+backleftseat+backrightseat+baggage+fuelweight+empty_weight;
totalmoment= (front_seat_arm*frontrightseat)+(front_seat_arm*frontleftseat)+(empty_weight_arm*empty_weight)+(fuel_arm*fuelweight)+(rear_seat_arm*backleftseat)+(rear_seat_arm*backrightseat)+(baggage_arm*baggage);
CG= totalmoment/totalweight;
fprintf('Your total weigth is %0.1f pounds, your CG is %0.1f inches, and your moment is %0.1f', totalweight, CG ,totalmoment)
if totalweight > max_ramp_weight
    fprintf('You Have exceeded max weight')
end
plot (CG,totalweight, '.', 'MarkerSize', 30) %<SM:PLOT>
hold on
grid on;
c = [93,93]; % x-coordinates of the endpoints
d = [0, 2450]; % y-coordinates of the endpoints
plot(c, d,'r')
a=[82,93];
b=[0,0];
plot(a,b,'r')
e=[82,87.5];
f=[2050,2450];
plot(e,f,'r')
g=[87.5,93];
h=[2450,2450];
plot(g,h,'r')
i=[82,82];
j=[0,2050];
plot(i,j,'r')
title('CG Envolope')
xlabel('CG (inches)')
ylabel('Weight (lbs)')
xlim([82 94])
ylim([0 2600])
hold off

%enjoy my scrap work from attempt 1 :)    .. .. . ..... ...  . .  . .. .  ... . .  ..  . .
%input weather minimums
%if x==2 %
%   wind=input('what is your maximum wind speed in MPH?');
%  ceiling=input('what is your minimum for clouds?');
%  . . .  . .. .. . . .. . . .. . .. . . .. . ...
%input airports
%numberofstops=input('\nHow many airports will you be going to? \nfor example If I was to take off from KHFD and fly to KHVN then fly back to KHFD, my awnser would be 3:');
%x=1; %for row of array airport will be saved in.
%A = airports. empty( 1,1) ;. . .

% for 1:numberofstops
%airport=input('','s'); . . ...

%x=x+1;  . .. . . . . .. . . . . .
%end . . .. . . ... .


%{
scrap work for later, testing idea to have all of code be able to be
accessed multiple times by selecting what segment of code be inputting a
number or string . . . ..                  .. . .  . .
x=1;
 . .. . ... .... 
if x >= 1
    action=input(''); %selects which part of the 
    %Input weather constraints
    if x==2 %
        wind=input('what is your maximum wind speed in MPH?');
        ceiling=input('what is your minimum for clouds?');
        
    end
    if x==1 %Find info regarding 
        takeoff=input('What is your starting airport? Please input airport code in all caps, for example Hartford Brainard Airport would be KHFD:');
        landing=input('What is your destination airport? Please input airport code in all caps, for example Hartford Brainard Airport would be KHFD:');
    end

    if x ==3 %weight and balence

    end 

end

%}
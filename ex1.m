%% Christos Mitropoulos - 03110103 - Management Systems Simulation

clear all;
close all;
%% create random sequences for demand and delivery time

 m_d=20; s_d=1.15; %mean value and sigma of demand
demand=round(normrnd(m_d,s_d,1e4,1)); %random values for demand


m_L=2; s_L=0.2*m_L;
L=round(normrnd(m_L,s_L,size(demand,1),size(demand,2)));

%   load('demand_L_data.mat');
  %% initialize variables
  storage_beforeDelivery=zeros(size(demand));
  order_made=zeros(size(demand)); orders_delivered=order_made;
  storage_afterDelivery_beforeDemand=order_made;
  storage_afterDemand=order_made;
  delivery_time = order_made;
  storage_initial=50;
  R=29; % when our storage has that amount of pieces we must order more products - Q amount
  Q = 98;      % the amount of pieces we order
  j=1;

fail=0;
orders_nb=0;
  
         storage_beforeDelivery(1)=storage_initial;
        storage_afterDelivery_beforeDemand(1)=storage_initial;
        storage_afterDemand(1)=storage_initial - round(demand(1));
        if storage_afterDemand(1)<=R  %% in case we have a small initial storage
            order_made(1)=Q;
        end
  %% begin simulation
  
 
for i=2:size(demand,1)
    
    
        storage_beforeDelivery(i)=storage_afterDemand(i-1);
        if(i>2)
        storage_afterDelivery_beforeDemand(i)=storage_beforeDelivery(i) + order_made(i-L(j));
        orders_delivered(i)= order_made(i-L(j));
        
        j=j+1;
        else 
            storage_afterDelivery_beforeDemand(i)=storage_beforeDelivery(i);
        end
        storage_afterDemand(i)=storage_afterDelivery_beforeDemand(i)- demand(i);
        if storage_afterDemand(i)<0
            fail = fail+1;
        end
        if storage_afterDemand(i)<=R 
            order_made(i)=Q;
            orders_nb=orders_nb+1;
            delivery_time(i+L(j))=L(j);
        end
    
    
end

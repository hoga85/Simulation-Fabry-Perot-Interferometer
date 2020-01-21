#Author: F-Y Lin
#Purpose: to simulate the Reflection Intensity of FOH sensor

#Symbol: 
# n: refractive index (n_air ~ 1)
# Ir: the intensity of reflection
# R: power reflectivity of optical interfaces.
# L: the distances between mirrors.4
# lambda: the wavelength of light.
# I_0: incident light power.
# Ref: [1] J. L. Santos, A. P. Leite, and D. A. Jackson, "Optical fiber sensing with a low-finesse Fabry-Perot cavity," Appl. Opt., vol. 31, no. 34, p. 7361, Dec. 1992.


## phi is the optical phase of FOH. 
## phi is determined by both L and lambda. 
## L is a fixed value when the FOH is made
## lambda is tunable via laser console. 


#clean the memeory
rm(list=ls()) 


#R packages used in this script
library(ggplot2)
library(ggpubr)


###################################################
# Scenario II -  When receving an US signal:
###################################################

# In this scenario, the wavelenght of light source is assumed to be a constant. 
# When the FOH sensor receives an Ultrasound signal, L chagnes accrodingly. 
# To measure an ultraound signal, it is better to operate the measurement within a linear region of the transfer function.
# The FOH resoponse at a wavelength close to but not identical to the resonant wavelength is often linear.

# Assumption:
# For L = 60090 nm, one of the resonant wavelengths is 1502.25 nm,
# because this wavelengh is an integer multipl of L, i.e., 1502.25*40 = 60090. 
# Here, the author add a 0.3 nm bias to the resonant wavelength.
bias_lambda = 0.3 #unit:nm

lambda = 1502.25+bias_lambda # bias the wavelength for the measurement purpose
amp_vibration = 1 #unit: nm
f_us = 5e6 #unit: Hz
t = seq(0,6e-7,6e-10)

L_vibration = 60090 + amp_vibration*cos(2*pi*f_us*t)
I_0 = 5 #unit: mW


n = 1 #refractive index of vacuum
R = 0.9
phi = (4*pi*L_vibration*n)/lambda


# Transfer function Ir:
amplitude = 2*R*I_0
numerator = 1-cos(phi)
denominator = 1 + R^2-2*R*cos(phi)
Ir = amplitude*numerator/denominator

# construct variable to a data frame
Data = data.frame(t,phi,L_vibration,Ir)


# plot with ggplot and 
plt_L_t = ggplot(Data, aes(L_vibration,t))+
  geom_point(color='red')+
  theme_bw()+
  theme(aspect.ratio=0.5)+
   scale_x_continuous(
     labels = scales::number_format(accuracy = 1))+
  xlab('Distance between two mirrors (nm)')+
  ylab('Time (sec)')


plt_L_Ir = ggplot(Data, aes(L_vibration,Ir))+
  geom_point(color='red')+
  theme_bw()+
  theme(aspect.ratio=0.5)+
   scale_x_continuous(
     labels = scales::number_format(accuracy = 1))+
  xlab('Distance between two mirrors (nm)')+
  ylab('Reflection Intensity (mW)')


plt_t_Ir= ggplot(Data, aes(t,Ir))+
  geom_point(color='red')+
  theme_bw()+
  theme(aspect.ratio=0.5)+
  xlab('Time (sec)')+
  ylab('Reflection Intensity (mW)')
  


###################################################
# Scenaro I - Initialisation - the wavelength sweeps:
###################################################

# In this scenario, there is no ultraound signal. 
# Therefore, L should be a constant (in the discussion here, 
# we ignore the effect of the environmental temperature on L.)
#
# The aim of initialisation is to find the Transfer Function of FOH.
# While L is regarded as a constant, the wavelength is swept from 1500 nm to 1504 nm.  


lambda = seq(1500,1504,0.01)# unit:nm
L = 60090 #unit: nm # 60090 is the resonant cavity length
I_0 = 5 #unit: mW


n = 1 #refractive index of vacuum
R = 0.9
phi1 = (4*pi*L*n)/lambda


# Transfer function Ir:
amplitude = 2*R*I_0
numerator = 1-cos(phi1)
denominator = 1 + R^2-2*R*cos(phi1)
Ir = amplitude*numerator/denominator



# create a variable call selected_range:
### 1. The optic phase of phi1 is simulating the vibration of L
### 2. The phi is an array of the optic phases during the wavelength sweeping. 
### 3. The selected_range is used to indicate what is the vibration of L 
###    in comparison to the overall transfer function.
### 4. The selected_range is annonated as red colour. 

min_phi = range(phi)[1]
max_phi = range(phi)[2]
selected_range = phi1 > min_phi & phi1 < max_phi

# Format the data to data frame.
wave_scanning = data.frame(phi1,lambda,Ir,selected_range)

## To plot data inside or outside the selected_range separately with the script below:
## data=wave_scanning[which(wave_scanning$selected_range == F),]



# plot with ggplot

plt_phi_Ir = ggplot(data = wave_scanning[which(wave_scanning$selected_range == F),],
                    aes(lambda, Ir))+
  geom_point( color='black')+
  geom_point(data = wave_scanning[which(wave_scanning$selected_range == T),],
             aes(lambda, Ir),color='red')+
  theme_bw()+
  theme(aspect.ratio=0.5)+
  scale_x_continuous(
    labels = scales::number_format(accuracy = 1))+
  xlab('Wavelength (nm)')+
  ylab('Reflection Intensity (mW)')

####################
#plot
ggarrange( plt_L_Ir,plt_t_Ir, plt_L_t, plt_phi_Ir,  nrow =2 , ncol = 2 )


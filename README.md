# Background
It is a simulation for the author to understand the behaviour of a fibre optic hydrophone (FOH). An FOH can be regarded as a Fabry-Perot-Interferometer (FPI) when it is served as an ultrasound sensor. 

## Fabry-Perot-Interferometer as an ultrasound sensor.
An FPI consists of a pair of mirrors. In certain conditions, the light trasmits into this pair of mirror would fully transmit through this pair of mirrors, and no reflection would occur. This is known as Fabry-Perot resonance. 

The R script `Simulation-Fabry-Perot-interferometer.r` simulates the transfer function the reflection intensity as a function of the optical phase [1]. 


There are two scenarios in this simulation [2]. 
### Scenario I - Initialisation 
The distance between two mirrors is presumed to be a constant. The transfer function is determined by sweeping the wavelength of light source. An example of the transfer function is as below:
* The transfer function of an FOH in the wavelength domain:
![image](https://github.com/hoga85/Simulation-Fabry-Perot-Interferometer/blob/master/figures/fig_TF_FOH_wavelength.png)

* The identical transfer function that expressed in the optical phase domain is as below:
![image](https://github.com/hoga85/Simulation-Fabry-Perot-Interferometer/blob/master/figures/fig_TF_FOH_optical-phase.png)

### Scenario II - acoustic wave measurement 
From the Scenario I, we know that the resonant wavelength is 1502.25 nm. To operatre the measurement at a linear region. A bias (0.3 nm) is added to the wavelength. As a result, the measurement is operated at 1502.55 nm. As the distance between two mirrors is assumed to be 60090 nm, the optical phase would be 502.5545 rad when no acoustic wave is applied.

Provided that an acoustic wave causes the mirrors to vibriate sinusoidally (cosine wave; 5 MHz as an example in this simulation) and its amplitude is 1 nm, then it implies that the optic phase would vary between 502.5545 + 0.0084 rad and 502.5545 - 0.0084 rad. Its correlation with the reflection intensity is visualised as below:

![image](https://github.com/hoga85/Simulation-Fabry-Perot-Interferometer/blob/master/figures/fig_TF_L-vibrate-optical-phase.png)

The equivalent correlation of the mirror distance and the reflection intensity is visualised as below:
![image](https://github.com/hoga85/Simulation-Fabry-Perot-Interferometer/blob/master/figures/fig_TF_L-vibrate.png)

This transfer function allows one to attain the acostic waveform via tracking the variation in the reflection intensity. More details on this can be seen in [2]. 

# Environment:
* Language: R version 3.5.3
* Integrated development environment (IDE): RStudio Version 1.2.1335

# R packages: 
* ggplot2
* ggpubr

# References: 
[1] J. L. Santos, A. P. Leite, and D. A. Jackson, “Optical fiber sensing with a low-finesse Fabry–Perot cavity,” Appl. Opt., vol. 31, no. 34, p. 7361, Dec. 1992.

[2] P. Morris, A. Hurrell, A. Shaw, E. Zhang, and P. Beard, “A Fabry–Pérot fiber-optic ultrasonic hydrophone for the simultaneous measurement of temperature and acoustic pressure,” J. Acoust. Soc. Am., vol. 125, no. 6, pp. 3611–3622, 2009.

![Fig 6.8](fig6_08.png)

**Figure 6.8**: Model prediction of the
sweet-spot sizes for different SFS setups
synthesizing a point source. As a
comparison a stereophony setup presents
the same source. The sweet-spot is
defined as all points where the absolute
localization error is less or equal to 5°.

## Steps for reproduction

Matlab/Octave:
```Matlab
>> sfs_circular
```
The above command will run for several hours.

Bash:
```Bash
$ gnuplot sweet_spot.gnu
```
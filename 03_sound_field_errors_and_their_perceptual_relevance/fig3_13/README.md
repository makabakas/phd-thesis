![Fig 3.13](fig3_13.png)

**Figure 3.13**: Sound pressure of a cosine shaped impulse synthesized as a
plane wave by NFC-HOA (2.45) and
WFS (2.57). Parameters: x_s = (0,−1,0),
x_ref = (0,0,0), t = 4.6 ms, 64 secondary
sources for the sampled distributions.

## Steps for reproduction

Matlab/Octave:
```Matlab
>> sound_field_time
```
The above command will need an internet connection as it will download mat-files
containing zeroing of Bessel functions of higher orders.

The results for the non-band-limited NFC-HOA graphs include numerical artifacts
around the secondary sources. This cannot be reproduced with current Matlab and
Octave versions. This highlights that the errors are really numerical in the
thesis and not part of the NFC-HOA solution.

Bash:
```Bash
$ gnuplot sound_field_time.gnu
```

## Problem solving

If you run the above command in Octave it could happen that you get an error
like
```
error: zp2sos: A(I,J): row index out of bounds; value 1 out of bound 0
```
This happens if you have a new version of the `zp2sos` Octave Forge function
installed. The problem was introduced with [commit
f248ba](http://sourceforge.net/p/octave/signal/ci/f248ba3244150e69e576d898161d8a0a8892b7c3/).
This error can be solved if you change line 105 in
`driving_function_imp_nfchoa_pw.m` of the Sound Field Synthesis Toolbox from
```Matlab
sos = zp2sos(p,z*c/R,2,'down','none');
```
to
```Matlab
[sos,~] = zp2sos(p,z*c/R,2,'down','none');
```
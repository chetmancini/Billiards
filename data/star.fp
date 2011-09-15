!!ARBfp1.0

ATTRIB icol = fragment.color;
ATTRIB texc = fragment.texcoord;

PARAM  half = { 0.5, 0.5, 0.0, 1.0 };

TEMP   ncol;
TEMP   dist;
TEMP   temp;

OUTPUT ocol = result.color;

# We must subtract and re-add (0.5, 0.5) on texture coordinates.

SUB    dist, texc, half;

# Scale the normal distribution texture inversely to the value of each channel.

RCP    ncol.r, icol.r;
RCP    ncol.g, icol.g;
RCP    ncol.b, icol.b;

# Perform the texture lookup separately for each color component.

MAD    temp, dist, ncol.r, half;
TEX    ocol.r, temp, texture[0], 2D;

MAD    temp, dist, ncol.g, half;
TEX    ocol.g, temp, texture[0], 2D;

MAD    temp, dist, ncol.b, half;
TEX    ocol.b, temp, texture[0], 2D;

# Assume additive blending, and set alpha to 1.

MOV    ocol.a, 1;

END

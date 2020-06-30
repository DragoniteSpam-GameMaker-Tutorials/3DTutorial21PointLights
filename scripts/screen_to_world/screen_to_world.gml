/// @description convert_2d_to_3d(x, y, view_mat, proj_mat)
/// @param x
/// @param y
/// @param view_mat
/// @param proj_mat
/*
Transforms a 2D coordinate (in window space) to a 3D vector.
Returns an array of the following format:
[dx, dy, dz, ox, oy, oz]
where [dx, dy, dz] is the direction vector and [ox, oy, oz] is the origin of the ray.

Works for both orthographic and perspective projections.

Script created by TheSnidr
(slightly modified by @dragonitespam)
*/
var _x = argument0;
var _y = argument1;
var V = argument2;
var P = argument3;

var mx = 2 * (_x / window_get_width() - .5) / P[0];
var my = 2 * (_y / window_get_height() - .5) / P[5];
var camX = - (V[12] * V[0] + V[13] * V[1] + V[14] * V[2]);
var camY = - (V[12] * V[4] + V[13] * V[5] + V[14] * V[6]);
var camZ = - (V[12] * V[8] + V[13] * V[9] + V[14] * V[10]);

if (P[15] == 0)
{    //This is a perspective projection
    return [V[2]  + mx * V[0] + my * V[1],
            V[6]  + mx * V[4] + my * V[5],
            V[10] + mx * V[8] + my * V[9],
            camX,
            camY,
            camZ];
}
else
{    //This is an ortho projection
    return [V[2],
            V[6],
            V[10],
            camX + mx * V[0] + my * V[1],
            camY + mx * V[4] + my * V[5],
            camZ + mx * V[8] + my * V[9]];
}
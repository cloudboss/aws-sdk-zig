/// Specify whether this output's video uses the D10 syntax. Keep the default
/// value to not use the syntax. Related settings: When you choose D10 for your
/// MXF profile, you must also set this value to D10.
pub const Mpeg2Syntax = enum {
    default,
    d_10,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .d_10 = "D_10",
    };
};

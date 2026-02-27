/// Hdr10 Settings
pub const Hdr10Settings = struct {
    /// Maximum Content Light Level
    /// An integer metadata value defining the maximum light level, in nits,
    /// of any single pixel within an encoded HDR video stream or file.
    max_cll: ?i32,

    /// Maximum Frame Average Light Level
    /// An integer metadata value defining the maximum average light level, in nits,
    /// for any single frame within an encoded HDR video stream or file.
    max_fall: ?i32,

    pub const json_field_names = .{
        .max_cll = "MaxCll",
        .max_fall = "MaxFall",
    };
};

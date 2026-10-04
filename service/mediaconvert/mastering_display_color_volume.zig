/// Mastering display color volume metadata (SMPTE ST 2086). Describes the color
/// volume of the display used to master the content. Chromaticity coordinates
/// are in units of 0.00002. Luminance values are in units of 0.0001 cd/m².
pub const MasteringDisplayColorVolume = struct {
    /// Blue primary chromaticity x coordinate, in units of 0.00002.
    blue_primary_x: ?i32 = null,

    /// Blue primary chromaticity y coordinate, in units of 0.00002.
    blue_primary_y: ?i32 = null,

    /// Green primary chromaticity x coordinate, in units of 0.00002.
    green_primary_x: ?i32 = null,

    /// Green primary chromaticity y coordinate, in units of 0.00002.
    green_primary_y: ?i32 = null,

    /// Maximum display mastering luminance, in units of 0.0001 cd/m².
    max_luminance: ?i64 = null,

    /// Minimum display mastering luminance, in units of 0.0001 cd/m².
    min_luminance: ?i64 = null,

    /// Red primary chromaticity x coordinate, in units of 0.00002.
    red_primary_x: ?i32 = null,

    /// Red primary chromaticity y coordinate, in units of 0.00002.
    red_primary_y: ?i32 = null,

    /// White point chromaticity x coordinate, in units of 0.00002.
    white_point_x: ?i32 = null,

    /// White point chromaticity y coordinate, in units of 0.00002.
    white_point_y: ?i32 = null,

    pub const json_field_names = .{
        .blue_primary_x = "BluePrimaryX",
        .blue_primary_y = "BluePrimaryY",
        .green_primary_x = "GreenPrimaryX",
        .green_primary_y = "GreenPrimaryY",
        .max_luminance = "MaxLuminance",
        .min_luminance = "MinLuminance",
        .red_primary_x = "RedPrimaryX",
        .red_primary_y = "RedPrimaryY",
        .white_point_x = "WhitePointX",
        .white_point_y = "WhitePointY",
    };
};

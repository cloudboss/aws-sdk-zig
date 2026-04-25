/// Controls the detail level and smoothness of generated isolines. More
/// detailed isolines provide better visual representation of reachable areas
/// but require more processing time and result in larger responses.
pub const IsolineGranularityOptions = struct {
    /// The maximum number of points used to define each isoline. Higher values
    /// create smoother, more detailed shapes.
    max_points: ?i32 = null,

    /// The maximum distance in meters between points along the isoline. Smaller
    /// values create more detailed shapes.
    ///
    /// **Unit**: `meters`
    max_resolution: i64 = 0,

    pub const json_field_names = .{
        .max_points = "MaxPoints",
        .max_resolution = "MaxResolution",
    };
};

/// Isoline granularity related options.
pub const IsolineGranularityOptions = struct {
    /// Maximum number of points of returned Isoline.
    max_points: ?i32 = null,

    /// Maximum resolution of the returned isoline.
    ///
    /// **Unit**: `meters`
    max_resolution: i64 = 0,

    pub const json_field_names = .{
        .max_points = "MaxPoints",
        .max_resolution = "MaxResolution",
    };
};

pub const TileAdditionalFeature = enum {
    /// Map elevation contour lines.
    contour_lines,
    /// Map hillshading details for shading elevation changes.
    hillshade,
    /// Map logistics details, including advanced pois and road networks.
    logistics,
    /// Map transit details.
    transit,

    pub const json_field_names = .{
        .contour_lines = "CONTOUR_LINES",
        .hillshade = "HILLSHADE",
        .logistics = "LOGISTICS",
        .transit = "TRANSIT",
    };
};

/// The width properties for a line.
pub const GeospatialLineWidth = struct {
    /// The positive value for the width of a line.
    line_width: ?f64 = null,

    pub const json_field_names = .{
        .line_width = "LineWidth",
    };
};

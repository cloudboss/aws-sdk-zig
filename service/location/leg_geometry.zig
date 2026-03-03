/// Contains the geometry details for each path between a pair of positions.
/// Used in plotting a route leg on a map.
pub const LegGeometry = struct {
    /// An ordered list of positions used to plot a route on a map.
    ///
    /// The first position is closest to the start position for the leg, and the
    /// last position is the closest to the end position for the leg.
    ///
    /// * For example, `[[-123.117, 49.284],[-123.115, 49.285],[-123.115, 49.285]]`
    line_string: ?[]const []const f64 = null,

    pub const json_field_names = .{
        .line_string = "LineString",
    };
};

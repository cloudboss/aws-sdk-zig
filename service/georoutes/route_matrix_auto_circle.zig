/// Provides the circle that was used while calculating the route.
pub const RouteMatrixAutoCircle = struct {
    /// The margin provided for the calculation.
    margin: i64 = 0,

    /// The maximum size of the radius provided for the calculation.
    max_radius: i64 = 0,

    pub const json_field_names = .{
        .margin = "Margin",
        .max_radius = "MaxRadius",
    };
};

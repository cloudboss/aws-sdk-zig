/// Options for the pedestrian leg of the transit route.
pub const RouteTransitPedestrianOptions = struct {
    /// Maximum walking distance allowed.
    ///
    /// **Unit**: `meters`
    max_distance: ?i64 = null,

    /// Walking speed.
    ///
    /// **Unit**: `kilometers per hour`
    speed: ?f64 = null,

    pub const json_field_names = .{
        .max_distance = "MaxDistance",
        .speed = "Speed",
    };
};

/// Options related to a pedestrian.
pub const WaypointOptimizationPedestrianOptions = struct {
    /// Walking speed.
    ///
    /// **Unit**: `kilometers per hour`
    speed: ?f64 = null,

    pub const json_field_names = .{
        .speed = "Speed",
    };
};

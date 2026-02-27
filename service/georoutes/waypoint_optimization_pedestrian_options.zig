/// Options related to a pedestrian.
pub const WaypointOptimizationPedestrianOptions = struct {
    /// Walking speed.
    ///
    /// **Unit**: `KilometersPerHour`
    speed: ?f64,

    pub const json_field_names = .{
        .speed = "Speed",
    };
};

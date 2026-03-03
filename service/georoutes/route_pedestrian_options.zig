/// Options related to the pedestrian.
pub const RoutePedestrianOptions = struct {
    /// Walking speed in Kilometers per hour.
    speed: ?f64 = null,

    pub const json_field_names = .{
        .speed = "Speed",
    };
};

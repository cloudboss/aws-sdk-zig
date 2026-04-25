/// Options related to the pedestrian. Not supported in `ap-southeast-1` and
/// `ap-southeast-5` regions for
/// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
pub const RoutePedestrianOptions = struct {
    /// Walking speed in Kilometers per hour.
    speed: ?f64 = null,

    pub const json_field_names = .{
        .speed = "Speed",
    };
};

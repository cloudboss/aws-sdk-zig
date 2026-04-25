const RouteEngineType = @import("route_engine_type.zig").RouteEngineType;
const RouteVehicleLicensePlate = @import("route_vehicle_license_plate.zig").RouteVehicleLicensePlate;

/// Travel mode options when the provided travel mode is `Car`. For
/// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers, `ap-southeast-1` and `ap-southeast-5` regions support only `LicensePlate` options.
pub const RouteCarOptions = struct {
    /// Engine type of the vehicle. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    engine_type: ?RouteEngineType = null,

    /// The vehicle License Plate.
    license_plate: ?RouteVehicleLicensePlate = null,

    /// Maximum speed specified. Not supported in `ap-southeast-1` and
    /// `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// **Unit**: `kilometers per hour`
    max_speed: ?f64 = null,

    /// The number of occupants in the vehicle. Not supported in `ap-southeast-1`
    /// and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ///
    /// Default value: `1`
    occupancy: ?i32 = null,

    pub const json_field_names = .{
        .engine_type = "EngineType",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
    };
};

const RouteEngineType = @import("route_engine_type.zig").RouteEngineType;
const RouteHazardousCargoType = @import("route_hazardous_cargo_type.zig").RouteHazardousCargoType;
const RouteVehicleLicensePlate = @import("route_vehicle_license_plate.zig").RouteVehicleLicensePlate;
const RouteTrailerOptions = @import("route_trailer_options.zig").RouteTrailerOptions;
const RouteTruckType = @import("route_truck_type.zig").RouteTruckType;
const WeightPerAxleGroup = @import("weight_per_axle_group.zig").WeightPerAxleGroup;

/// Travel mode options when the provided travel mode is `Truck`. Not supported
/// in `ap-southeast-1` and `ap-southeast-5` regions for
/// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
pub const RouteTruckOptions = struct {
    /// Total number of axles of the vehicle.
    axle_count: ?i32 = null,

    /// Engine type of the vehicle.
    engine_type: ?RouteEngineType = null,

    /// Gross weight of the vehicle including trailers, and goods at capacity.
    ///
    /// **Unit**: `kilograms`
    gross_weight: i64 = 0,

    /// List of Hazardous cargo contained in the vehicle.
    hazardous_cargos: ?[]const RouteHazardousCargoType = null,

    /// Height of the vehicle.
    ///
    /// **Unit**: `centimeters`
    height: i64 = 0,

    /// Height of the vehicle above its first axle.
    ///
    /// **Unit**: `centimeters`
    height_above_first_axle: i64 = 0,

    /// Kingpin to rear axle length of the vehicle.
    ///
    /// **Unit**: `centimeters`
    kpra_length: i64 = 0,

    /// Length of the vehicle.
    ///
    /// **Unit**: `c`
    length: i64 = 0,

    /// The vehicle License Plate.
    license_plate: ?RouteVehicleLicensePlate = null,

    /// Maximum speed
    ///
    /// **Unit**: `kilometers per hour`
    max_speed: ?f64 = null,

    /// The number of occupants in the vehicle.
    ///
    /// Default value: `1`
    occupancy: ?i32 = null,

    /// Payload capacity of the vehicle and trailers attached.
    ///
    /// **Unit**: `kilograms`
    payload_capacity: i64 = 0,

    /// Number of tires on the vehicle.
    tire_count: ?i32 = null,

    /// Trailer options corresponding to the vehicle.
    trailer: ?RouteTrailerOptions = null,

    /// The type of truck: `LightTruck` for smaller delivery vehicles, `
    /// StraightTruck` for rigid body trucks, or `Tractor` for tractor-trailer
    /// combinations.
    truck_type: ?RouteTruckType = null,

    /// The tunnel restriction code.
    ///
    /// Tunnel categories in this list indicate the restrictions which apply to
    /// certain tunnels in Great Britain. They relate to the types of dangerous
    /// goods that can be transported through them.
    ///
    /// * *Tunnel Category B*
    ///
    /// * *Risk Level*: Limited risk
    /// * *Restrictions*: Few restrictions
    ///
    /// * *Tunnel Category C*
    ///
    /// * *Risk Level*: Medium risk
    /// * *Restrictions*: Some restrictions
    ///
    /// * *Tunnel Category D*
    ///
    /// * *Risk Level*: High risk
    /// * *Restrictions*: Many restrictions occur
    ///
    /// * *Tunnel Category E*
    ///
    /// * *Risk Level*: Very high risk
    /// * *Restrictions*: Restricted tunnel
    tunnel_restriction_code: ?[]const u8 = null,

    /// Heaviest weight per axle irrespective of the axle type or the axle group.
    /// Meant for usage in countries where the differences in axle types or axle
    /// groups are not distinguished.
    ///
    /// **Unit**: `kilograms`
    weight_per_axle: i64 = 0,

    /// Specifies the total weight for the specified axle group. Meant for usage in
    /// countries that have different regulations based on the axle group type.
    ///
    /// **Unit**: `kilograms`
    weight_per_axle_group: ?WeightPerAxleGroup = null,

    /// Width of the vehicle.
    ///
    /// **Unit**: `centimeters`
    width: i64 = 0,

    pub const json_field_names = .{
        .axle_count = "AxleCount",
        .engine_type = "EngineType",
        .gross_weight = "GrossWeight",
        .hazardous_cargos = "HazardousCargos",
        .height = "Height",
        .height_above_first_axle = "HeightAboveFirstAxle",
        .kpra_length = "KpraLength",
        .length = "Length",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
        .payload_capacity = "PayloadCapacity",
        .tire_count = "TireCount",
        .trailer = "Trailer",
        .truck_type = "TruckType",
        .tunnel_restriction_code = "TunnelRestrictionCode",
        .weight_per_axle = "WeightPerAxle",
        .weight_per_axle_group = "WeightPerAxleGroup",
        .width = "Width",
    };
};

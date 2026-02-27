const RouteMatrixHazardousCargoType = @import("route_matrix_hazardous_cargo_type.zig").RouteMatrixHazardousCargoType;
const RouteMatrixVehicleLicensePlate = @import("route_matrix_vehicle_license_plate.zig").RouteMatrixVehicleLicensePlate;
const RouteMatrixTrailerOptions = @import("route_matrix_trailer_options.zig").RouteMatrixTrailerOptions;
const RouteMatrixTruckType = @import("route_matrix_truck_type.zig").RouteMatrixTruckType;
const WeightPerAxleGroup = @import("weight_per_axle_group.zig").WeightPerAxleGroup;

/// Travel mode options when the provided travel mode is "Truck"
pub const RouteMatrixTruckOptions = struct {
    /// Total number of axles of the vehicle.
    axle_count: ?i32,

    /// Gross weight of the vehicle including trailers, and goods at capacity.
    ///
    /// **Unit**: `Kilograms`
    gross_weight: i64 = 0,

    /// List of Hazardous cargo contained in the vehicle.
    hazardous_cargos: ?[]const RouteMatrixHazardousCargoType,

    /// Height of the vehicle.
    ///
    /// **Unit**: `centimeters`
    height: i64 = 0,

    /// Kingpin to rear axle length of the vehicle
    ///
    /// **Unit**: `centimeters`
    kpra_length: i64 = 0,

    /// Length of the vehicle.
    ///
    /// **Unit**: `centimeters`
    length: i64 = 0,

    /// The vehicle License Plate.
    license_plate: ?RouteMatrixVehicleLicensePlate,

    /// Maximum speed
    ///
    /// **Unit**: `KilometersPerHour`
    max_speed: ?f64,

    /// The number of occupants in the vehicle.
    ///
    /// Default Value: `1`
    occupancy: ?i32,

    /// Payload capacity of the vehicle and trailers attached.
    ///
    /// **Unit**: `kilograms`
    payload_capacity: i64 = 0,

    /// Trailer options corresponding to the vehicle.
    trailer: ?RouteMatrixTrailerOptions,

    /// Type of the truck.
    truck_type: ?RouteMatrixTruckType,

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
    tunnel_restriction_code: ?[]const u8,

    /// Heaviest weight per axle irrespective of the axle type or the axle group.
    /// Meant for usage in countries where the differences in axle types or axle
    /// groups are not distinguished.
    ///
    /// **Unit**: `Kilograms`
    weight_per_axle: i64 = 0,

    /// Specifies the total weight for the specified axle group. Meant for usage in
    /// countries that have different regulations based on the axle group type.
    weight_per_axle_group: ?WeightPerAxleGroup,

    /// Width of the vehicle.
    ///
    /// **Unit**: `centimeters`
    width: i64 = 0,

    pub const json_field_names = .{
        .axle_count = "AxleCount",
        .gross_weight = "GrossWeight",
        .hazardous_cargos = "HazardousCargos",
        .height = "Height",
        .kpra_length = "KpraLength",
        .length = "Length",
        .license_plate = "LicensePlate",
        .max_speed = "MaxSpeed",
        .occupancy = "Occupancy",
        .payload_capacity = "PayloadCapacity",
        .trailer = "Trailer",
        .truck_type = "TruckType",
        .tunnel_restriction_code = "TunnelRestrictionCode",
        .weight_per_axle = "WeightPerAxle",
        .weight_per_axle_group = "WeightPerAxleGroup",
        .width = "Width",
    };
};

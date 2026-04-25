const WaypointOptimizationHazardousCargoType = @import("waypoint_optimization_hazardous_cargo_type.zig").WaypointOptimizationHazardousCargoType;
const WaypointOptimizationTrailerOptions = @import("waypoint_optimization_trailer_options.zig").WaypointOptimizationTrailerOptions;
const WaypointOptimizationTruckType = @import("waypoint_optimization_truck_type.zig").WaypointOptimizationTruckType;

/// Travel mode options when the provided travel mode is `Truck`.
pub const WaypointOptimizationTruckOptions = struct {
    /// Gross weight of the vehicle including trailers, and goods at capacity.
    ///
    /// **Unit**: `kilograms`
    gross_weight: i64 = 0,

    /// List of Hazardous cargo contained in the vehicle.
    hazardous_cargos: ?[]const WaypointOptimizationHazardousCargoType = null,

    /// Height of the vehicle.
    ///
    /// **Unit**: `centimeters`
    height: i64 = 0,

    /// Length of the vehicle.
    ///
    /// **Unit**: `centimeters`
    length: i64 = 0,

    /// Trailer options corresponding to the vehicle.
    trailer: ?WaypointOptimizationTrailerOptions = null,

    /// The type of truck: `LightTruck` for smaller delivery vehicles, `
    /// StraightTruck` for rigid body trucks, or `Tractor` for tractor-trailer
    /// combinations.
    truck_type: ?WaypointOptimizationTruckType = null,

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

    /// Width of the vehicle.
    ///
    /// **Unit**: `centimeters`
    width: i64 = 0,

    pub const json_field_names = .{
        .gross_weight = "GrossWeight",
        .hazardous_cargos = "HazardousCargos",
        .height = "Height",
        .length = "Length",
        .trailer = "Trailer",
        .truck_type = "TruckType",
        .tunnel_restriction_code = "TunnelRestrictionCode",
        .weight_per_axle = "WeightPerAxle",
        .width = "Width",
    };
};

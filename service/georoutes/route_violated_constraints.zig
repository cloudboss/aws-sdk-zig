const RouteNoticeDetailRange = @import("route_notice_detail_range.zig").RouteNoticeDetailRange;
const RouteHazardousCargoType = @import("route_hazardous_cargo_type.zig").RouteHazardousCargoType;
const RouteWeightConstraint = @import("route_weight_constraint.zig").RouteWeightConstraint;
const WeightPerAxleGroup = @import("weight_per_axle_group.zig").WeightPerAxleGroup;
const RouteTruckType = @import("route_truck_type.zig").RouteTruckType;

/// This property contains a summary of violated constraints.
pub const RouteViolatedConstraints = struct {
    /// This restriction applies to truck cargo, where the resulting route excludes
    /// roads on which hazardous materials are prohibited from being transported.
    all_hazards_restricted: ?bool = null,

    /// Total number of axles of the vehicle.
    axle_count: ?RouteNoticeDetailRange = null,

    /// List of Hazardous cargo contained in the vehicle.
    hazardous_cargos: []const RouteHazardousCargoType,

    /// The maximum height of the vehicle.
    max_height: i64 = 0,

    /// The maximum Kpra length of the vehicle.
    ///
    /// **Unit**: `centimeters`
    max_kpra_length: i64 = 0,

    /// The maximum length of the vehicle.
    max_length: i64 = 0,

    /// The maximum load capacity of the vehicle.
    ///
    /// **Unit**: `kilograms`
    max_payload_capacity: i64 = 0,

    /// The maximum weight of the route.
    ///
    /// **Unit**: `Kilograms`
    max_weight: ?RouteWeightConstraint = null,

    /// The maximum weight per axle of the vehicle.
    ///
    /// **Unit**: `Kilograms`
    max_weight_per_axle: i64 = 0,

    /// The maximum weight per axle group of the vehicle.
    ///
    /// **Unit**: `Kilograms`
    max_weight_per_axle_group: ?WeightPerAxleGroup = null,

    /// The maximum width of the vehicle.
    max_width: i64 = 0,

    /// The number of occupants in the vehicle.
    ///
    /// Default Value: `1`
    occupancy: ?RouteNoticeDetailRange = null,

    /// Access radius restrictions based on time.
    restricted_times: ?[]const u8 = null,

    /// The time dependent constraint.
    time_dependent: ?bool = null,

    /// Number of trailers attached to the vehicle.
    ///
    /// Default Value: `0`
    trailer_count: ?RouteNoticeDetailRange = null,

    /// Travel mode corresponding to the leg.
    travel_mode: ?bool = null,

    /// Truck road type identifiers. `BK1` through `BK4` apply only to Sweden.
    /// `A2,A4,B2,B4,C,D,ET2,ET4` apply only to Mexico.
    ///
    /// There are currently no other supported values as of 26th April 2024.
    truck_road_type: ?[]const u8 = null,

    /// Type of the truck.
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

    pub const json_field_names = .{
        .all_hazards_restricted = "AllHazardsRestricted",
        .axle_count = "AxleCount",
        .hazardous_cargos = "HazardousCargos",
        .max_height = "MaxHeight",
        .max_kpra_length = "MaxKpraLength",
        .max_length = "MaxLength",
        .max_payload_capacity = "MaxPayloadCapacity",
        .max_weight = "MaxWeight",
        .max_weight_per_axle = "MaxWeightPerAxle",
        .max_weight_per_axle_group = "MaxWeightPerAxleGroup",
        .max_width = "MaxWidth",
        .occupancy = "Occupancy",
        .restricted_times = "RestrictedTimes",
        .time_dependent = "TimeDependent",
        .trailer_count = "TrailerCount",
        .travel_mode = "TravelMode",
        .truck_road_type = "TruckRoadType",
        .truck_type = "TruckType",
        .tunnel_restriction_code = "TunnelRestrictionCode",
    };
};

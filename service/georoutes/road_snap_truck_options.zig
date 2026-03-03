const RoadSnapHazardousCargoType = @import("road_snap_hazardous_cargo_type.zig").RoadSnapHazardousCargoType;
const RoadSnapTrailerOptions = @import("road_snap_trailer_options.zig").RoadSnapTrailerOptions;

/// Travel mode options when the provided travel mode is "Truck".
pub const RoadSnapTruckOptions = struct {
    /// Gross weight of the vehicle including trailers, and goods at capacity.
    ///
    /// **Unit**: `Kilograms`
    gross_weight: i64 = 0,

    /// List of Hazardous cargos contained in the vehicle.
    hazardous_cargos: ?[]const RoadSnapHazardousCargoType = null,

    /// Height of the vehicle.
    ///
    /// **Unit**: `centimeters`
    height: i64 = 0,

    /// Length of the vehicle.
    ///
    /// **Unit**: `centimeters`
    length: i64 = 0,

    /// Trailer options corresponding to the vehicle.
    trailer: ?RoadSnapTrailerOptions = null,

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

    /// Width of the vehicle in centimenters.
    width: i64 = 0,

    pub const json_field_names = .{
        .gross_weight = "GrossWeight",
        .hazardous_cargos = "HazardousCargos",
        .height = "Height",
        .length = "Length",
        .trailer = "Trailer",
        .tunnel_restriction_code = "TunnelRestrictionCode",
        .width = "Width",
    };
};

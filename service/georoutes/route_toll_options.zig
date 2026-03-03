const RouteEmissionType = @import("route_emission_type.zig").RouteEmissionType;
const RouteTollVehicleCategory = @import("route_toll_vehicle_category.zig").RouteTollVehicleCategory;

/// Options related to Tolls on a route.
pub const RouteTollOptions = struct {
    /// Specifies if the user has valid transponder with access to all toll systems.
    /// This impacts toll calculation, and if true the price with transponders is
    /// used.
    all_transponders: ?bool = null,

    /// Specifies if the user has valid vignettes with access for all toll roads. If
    /// a user has a vignette for a toll road, then toll cost for that road is
    /// omitted since no further payment is necessary.
    all_vignettes: ?bool = null,

    /// Currency code corresponding to the price. This is the same as Currency
    /// specified in the request.
    currency: ?[]const u8 = null,

    /// Emission type of the vehicle for toll cost calculation.
    ///
    /// **Valid values**: `Euro1, Euro2, Euro3, Euro4, Euro5, Euro6, EuroEev`
    emission_type: ?RouteEmissionType = null,

    /// Vehicle category for toll cost calculation.
    vehicle_category: ?RouteTollVehicleCategory = null,

    pub const json_field_names = .{
        .all_transponders = "AllTransponders",
        .all_vignettes = "AllVignettes",
        .currency = "Currency",
        .emission_type = "EmissionType",
        .vehicle_category = "VehicleCategory",
    };
};

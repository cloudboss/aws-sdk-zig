const RouteFerryLegDetails = @import("route_ferry_leg_details.zig").RouteFerryLegDetails;
const RouteLegGeometry = @import("route_leg_geometry.zig").RouteLegGeometry;
const RoutePedestrianLegDetails = @import("route_pedestrian_leg_details.zig").RoutePedestrianLegDetails;
const RouteLegTravelMode = @import("route_leg_travel_mode.zig").RouteLegTravelMode;
const RouteLegType = @import("route_leg_type.zig").RouteLegType;
const RouteVehicleLegDetails = @import("route_vehicle_leg_details.zig").RouteVehicleLegDetails;

/// A leg is a section of a route from one waypoint to the next. A leg could be
/// of type Vehicle, Pedestrian or Ferry. Legs of different types could occur
/// together within a single route. For example, a car employing the use of a
/// Ferry will contain Vehicle legs corresponding to journey on land, and Ferry
/// legs corresponding to the journey via Ferry.
pub const RouteLeg = struct {
    /// FerryLegDetails is populated when the Leg type is Ferry, and provides
    /// additional information that is specific
    ferry_leg_details: ?RouteFerryLegDetails,

    /// Geometry of the area to be avoided.
    geometry: RouteLegGeometry,

    /// List of languages for instructions within steps in the response.
    language: ?[]const u8,

    /// Details related to the pedestrian leg.
    pedestrian_leg_details: ?RoutePedestrianLegDetails,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// Default Value: `Car`
    travel_mode: RouteLegTravelMode,

    /// Type of the leg.
    type: RouteLegType,

    /// Details related to the vehicle leg.
    vehicle_leg_details: ?RouteVehicleLegDetails,

    pub const json_field_names = .{
        .ferry_leg_details = "FerryLegDetails",
        .geometry = "Geometry",
        .language = "Language",
        .pedestrian_leg_details = "PedestrianLegDetails",
        .travel_mode = "TravelMode",
        .type = "Type",
        .vehicle_leg_details = "VehicleLegDetails",
    };
};

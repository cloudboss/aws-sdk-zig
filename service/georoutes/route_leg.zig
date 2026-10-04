const RouteFerryLegDetails = @import("route_ferry_leg_details.zig").RouteFerryLegDetails;
const RouteLegGeometry = @import("route_leg_geometry.zig").RouteLegGeometry;
const RoutePedestrianLegDetails = @import("route_pedestrian_leg_details.zig").RoutePedestrianLegDetails;
const RouteRentalLegDetails = @import("route_rental_leg_details.zig").RouteRentalLegDetails;
const RouteTaxiLegDetails = @import("route_taxi_leg_details.zig").RouteTaxiLegDetails;
const RouteTransitLegDetails = @import("route_transit_leg_details.zig").RouteTransitLegDetails;
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
    /// additional information that is specific to ferry travel. Not supported in
    /// `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    ferry_leg_details: ?RouteFerryLegDetails = null,

    /// Geometry of the area to be avoided.
    geometry: RouteLegGeometry,

    /// List of languages for instructions within steps in the response. Not
    /// supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    language: ?[]const u8 = null,

    /// Details related to the pedestrian leg.
    pedestrian_leg_details: ?RoutePedestrianLegDetails = null,

    /// Details related to the rental leg.
    ///
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    rental_leg_details: ?RouteRentalLegDetails = null,

    /// Details related to the taxi leg.
    ///
    /// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
    /// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
    taxi_leg_details: ?RouteTaxiLegDetails = null,

    /// Details related to the transit leg.
    transit_leg_details: ?RouteTransitLegDetails = null,

    /// Specifies the mode of transport when calculating a route. Used in estimating
    /// the speed of travel and road compatibility.
    ///
    /// Default value: `Car`
    travel_mode: RouteLegTravelMode,

    /// Type of the leg.
    @"type": RouteLegType,

    /// Details related to the vehicle leg.
    vehicle_leg_details: ?RouteVehicleLegDetails = null,

    pub const json_field_names = .{
        .ferry_leg_details = "FerryLegDetails",
        .geometry = "Geometry",
        .language = "Language",
        .pedestrian_leg_details = "PedestrianLegDetails",
        .rental_leg_details = "RentalLegDetails",
        .taxi_leg_details = "TaxiLegDetails",
        .transit_leg_details = "TransitLegDetails",
        .travel_mode = "TravelMode",
        .@"type" = "Type",
        .vehicle_leg_details = "VehicleLegDetails",
    };
};

const RouteAccessibilityAttribute = @import("route_accessibility_attribute.zig").RouteAccessibilityAttribute;
const RouteIntermodalPedestrianOptions = @import("route_intermodal_pedestrian_options.zig").RouteIntermodalPedestrianOptions;
const RouteIntermodalRentalOptions = @import("route_intermodal_rental_options.zig").RouteIntermodalRentalOptions;
const RouteIntermodalTaxiOptions = @import("route_intermodal_taxi_options.zig").RouteIntermodalTaxiOptions;
const RouteIntermodalTransitOptions = @import("route_intermodal_transit_options.zig").RouteIntermodalTransitOptions;
const RouteIntermodalVehicleOptions = @import("route_intermodal_vehicle_options.zig").RouteIntermodalVehicleOptions;

/// Options related to intermodal routing.
///
/// Not supported in `ap-southeast-1` and `ap-southeast-5` regions for
/// [GrabMaps](https://docs.aws.amazon.com/location/latest/developerguide/GrabMaps.html) customers.
pub const RouteIntermodalOptions = struct {
    /// Accessibility attributes to consider when calculating the route.
    accessibility_attributes: ?[]const RouteAccessibilityAttribute = null,

    /// Maximum number of transfers allowed when calculating the route.
    max_transfers: ?i32 = null,

    /// Options for the pedestrian leg of the intermodal route.
    pedestrian: ?RouteIntermodalPedestrianOptions = null,

    /// Options for the rental leg of the intermodal route.
    rental: ?RouteIntermodalRentalOptions = null,

    /// Options for the taxi leg of the intermodal route.
    taxi: ?RouteIntermodalTaxiOptions = null,

    /// Options for the transit leg of the intermodal route.
    transit: ?RouteIntermodalTransitOptions = null,

    /// Options for the vehicle leg of the intermodal route.
    vehicle: ?RouteIntermodalVehicleOptions = null,

    pub const json_field_names = .{
        .accessibility_attributes = "AccessibilityAttributes",
        .max_transfers = "MaxTransfers",
        .pedestrian = "Pedestrian",
        .rental = "Rental",
        .taxi = "Taxi",
        .transit = "Transit",
        .vehicle = "Vehicle",
    };
};

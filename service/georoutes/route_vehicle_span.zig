const RouteSpanCarAccessAttribute = @import("route_span_car_access_attribute.zig").RouteSpanCarAccessAttribute;
const RouteSpanDynamicSpeedDetails = @import("route_span_dynamic_speed_details.zig").RouteSpanDynamicSpeedDetails;
const RouteSpanGateAttribute = @import("route_span_gate_attribute.zig").RouteSpanGateAttribute;
const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteSpanRailwayCrossingAttribute = @import("route_span_railway_crossing_attribute.zig").RouteSpanRailwayCrossingAttribute;
const RouteSpanRoadAttribute = @import("route_span_road_attribute.zig").RouteSpanRoadAttribute;
const RouteNumber = @import("route_number.zig").RouteNumber;
const RouteSpanScooterAccessAttribute = @import("route_span_scooter_access_attribute.zig").RouteSpanScooterAccessAttribute;
const RouteSpanSpeedLimitDetails = @import("route_span_speed_limit_details.zig").RouteSpanSpeedLimitDetails;
const RouteSpanTruckAccessAttribute = @import("route_span_truck_access_attribute.zig").RouteSpanTruckAccessAttribute;

/// Span computed for the requested SpanAdditionalFeatures.
pub const RouteVehicleSpan = struct {
    /// Duration of the computed span without traffic congestion.
    ///
    /// **Unit**: `seconds`
    best_case_duration: i64 = 0,

    /// Access attributes for a car corresponding to the span.
    car_access: ?[]const RouteSpanCarAccessAttribute,

    /// 3 letter Country code corresponding to the Span.
    country: ?[]const u8,

    /// Distance of the computed span. This feature doesn't split a span, but is
    /// always computed on a span split by other properties.
    distance: i64 = 0,

    /// Duration of the computed span. This feature doesn't split a span, but is
    /// always computed on a span split by other properties.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Dynamic speed details corresponding to the span.
    ///
    /// **Unit**: `KilometersPerHour`
    dynamic_speed: ?RouteSpanDynamicSpeedDetails,

    /// Functional classification of the road segment corresponding to the span.
    functional_classification: ?i32,

    /// Attributes corresponding to a gate. The gate is present at the end of the
    /// returned span.
    gate: ?RouteSpanGateAttribute,

    /// Offset in the leg geometry corresponding to the start of this span.
    geometry_offset: ?i32,

    /// Incidents corresponding to the span. These index into the Incidents in the
    /// parent Leg.
    incidents: ?[]const i32,

    /// Provides an array of names of the vehicle span in available languages.
    names: ?[]const LocalizedString,

    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation.
    notices: ?[]const i32,

    /// Attributes corresponding to a railway crossing. The gate is present at the
    /// end of the returned span.
    railway_crossing: ?RouteSpanRailwayCrossingAttribute,

    /// 2-3 letter Region code corresponding to the Span. This is either a province
    /// or a state.
    region: ?[]const u8,

    /// Attributes for the road segment corresponding to the span.
    road_attributes: ?[]const RouteSpanRoadAttribute,

    /// Designated route name or number corresponding to the span.
    route_numbers: ?[]const RouteNumber,

    /// Access attributes for a scooter corresponding to the span.
    scooter_access: ?[]const RouteSpanScooterAccessAttribute,

    /// Speed limit details corresponding to the span.
    ///
    /// **Unit**: `KilometersPerHour`
    speed_limit: ?RouteSpanSpeedLimitDetails,

    /// Toll systems are authorities that collect payments for the toll.
    toll_systems: ?[]const i32,

    /// Access attributes for a truck corresponding to the span.
    truck_access: ?[]const RouteSpanTruckAccessAttribute,

    /// Truck road type identifiers. `BK1` through `BK4` apply only to Sweden.
    /// `A2,A4,B2,B4,C,D,ET2,ET4` apply only to Mexico.
    ///
    /// There are currently no other supported values as of 26th April 2024.
    truck_road_types: ?[]const i32,

    /// Duration of the computed span under typical traffic congestion.
    ///
    /// **Unit**: `seconds`
    typical_duration: i64 = 0,

    /// Zones corresponding to this leg of the route.
    zones: ?[]const i32,

    pub const json_field_names = .{
        .best_case_duration = "BestCaseDuration",
        .car_access = "CarAccess",
        .country = "Country",
        .distance = "Distance",
        .duration = "Duration",
        .dynamic_speed = "DynamicSpeed",
        .functional_classification = "FunctionalClassification",
        .gate = "Gate",
        .geometry_offset = "GeometryOffset",
        .incidents = "Incidents",
        .names = "Names",
        .notices = "Notices",
        .railway_crossing = "RailwayCrossing",
        .region = "Region",
        .road_attributes = "RoadAttributes",
        .route_numbers = "RouteNumbers",
        .scooter_access = "ScooterAccess",
        .speed_limit = "SpeedLimit",
        .toll_systems = "TollSystems",
        .truck_access = "TruckAccess",
        .truck_road_types = "TruckRoadTypes",
        .typical_duration = "TypicalDuration",
        .zones = "Zones",
    };
};

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
    car_access: ?[]const RouteSpanCarAccessAttribute = null,

    /// 3 letter Country code corresponding to the Span.
    country: ?[]const u8 = null,

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
    /// **Unit**: `kilometers per hour`
    dynamic_speed: ?RouteSpanDynamicSpeedDetails = null,

    /// A numerical value indicating the functional classification of the road
    /// segment corresponding to the span.
    ///
    /// Classification values are part of the hierarchical network that helps
    /// determine a logical and efficient route, and have the following definitions:
    ///
    /// * Roads that allow for high volume, maximum speed traffic movement between
    ///   and through major metropolitan areas.
    /// * Roads that are used to channel traffic to functional class 1 roads for
    ///   travel between and through cities in the shortest amount of time.
    /// * Roads that intersect functional class 2 roads and provide a high volume of
    ///   traffic movement at a lower level of mobility than functional class 2
    ///   roads.
    /// * Roads that provide for a high volume of traffic movement at moderate
    ///   speeds between neighborhoods.
    /// * Roads with volume and traffic movement below the level of any other
    ///   functional class.
    functional_classification: ?i32 = null,

    /// Attributes corresponding to a gate. The gate is present at the end of the
    /// returned span.
    gate: ?RouteSpanGateAttribute = null,

    /// Offset in the leg geometry corresponding to the start of this span.
    geometry_offset: ?i32 = null,

    /// Incidents corresponding to the span. These index into the Incidents in the
    /// parent Leg.
    incidents: ?[]const i32 = null,

    /// Provides an array of names of the vehicle span in available languages.
    names: ?[]const LocalizedString = null,

    /// Notices are additional information returned that indicate issues that
    /// occurred during route calculation.
    notices: ?[]const i32 = null,

    /// Attributes corresponding to a railway crossing. The gate is present at the
    /// end of the returned span.
    railway_crossing: ?RouteSpanRailwayCrossingAttribute = null,

    /// 2-3 letter Region code corresponding to the Span. This is either a province
    /// or a state.
    region: ?[]const u8 = null,

    /// Attributes for the road segment corresponding to the span.
    road_attributes: ?[]const RouteSpanRoadAttribute = null,

    /// Designated route name or number corresponding to the span.
    route_numbers: ?[]const RouteNumber = null,

    /// Access attributes for a scooter corresponding to the span.
    scooter_access: ?[]const RouteSpanScooterAccessAttribute = null,

    /// Speed limit details corresponding to the span.
    ///
    /// **Unit**: `kilometers per hour`
    speed_limit: ?RouteSpanSpeedLimitDetails = null,

    /// Toll systems are authorities that collect payments for the toll.
    toll_systems: ?[]const i32 = null,

    /// Access attributes for a truck corresponding to the span.
    truck_access: ?[]const RouteSpanTruckAccessAttribute = null,

    /// Truck road type identifiers. `BK1` through `BK4` apply only to Sweden.
    /// `A2,A4,B2,B4,C,D,ET2,ET4` apply only to Mexico.
    ///
    /// There are currently no other supported values as of 26th April 2024.
    truck_road_types: ?[]const i32 = null,

    /// Duration of the computed span under typical traffic congestion.
    ///
    /// **Unit**: `seconds`
    typical_duration: i64 = 0,

    /// Zones corresponding to this leg of the route.
    zones: ?[]const i32 = null,

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

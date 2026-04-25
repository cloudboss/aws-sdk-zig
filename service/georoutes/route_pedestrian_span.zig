const RouteSpanDynamicSpeedDetails = @import("route_span_dynamic_speed_details.zig").RouteSpanDynamicSpeedDetails;
const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteSpanPedestrianAccessAttribute = @import("route_span_pedestrian_access_attribute.zig").RouteSpanPedestrianAccessAttribute;
const RouteSpanRoadAttribute = @import("route_span_road_attribute.zig").RouteSpanRoadAttribute;
const RouteNumber = @import("route_number.zig").RouteNumber;
const RouteSpanSpeedLimitDetails = @import("route_span_speed_limit_details.zig").RouteSpanSpeedLimitDetails;

/// Span computed for the requested SpanAdditionalFeatures.
pub const RoutePedestrianSpan = struct {
    /// Duration of the computed span without traffic congestion.
    ///
    /// **Unit**: `seconds`
    best_case_duration: i64 = 0,

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

    /// Offset in the leg geometry corresponding to the start of this span.
    geometry_offset: ?i32 = null,

    /// Incidents corresponding to the span. These index into the Incidents in the
    /// parent Leg.
    incidents: ?[]const i32 = null,

    /// Provides an array of names of the pedestrian span in available languages.
    names: ?[]const LocalizedString = null,

    /// Access attributes for a pedestrian corresponding to the span.
    pedestrian_access: ?[]const RouteSpanPedestrianAccessAttribute = null,

    /// 2-3 letter Region code corresponding to the Span. This is either a province
    /// or a state.
    region: ?[]const u8 = null,

    /// Attributes for the road segment corresponding to the span.
    road_attributes: ?[]const RouteSpanRoadAttribute = null,

    /// Designated route name or number corresponding to the span.
    route_numbers: ?[]const RouteNumber = null,

    /// Speed limit details corresponding to the span.
    ///
    /// **Unit**: `kilometers per hour`
    speed_limit: ?RouteSpanSpeedLimitDetails = null,

    /// Duration of the computed span under typical traffic congestion.
    ///
    /// **Unit**: `seconds`
    typical_duration: i64 = 0,

    pub const json_field_names = .{
        .best_case_duration = "BestCaseDuration",
        .country = "Country",
        .distance = "Distance",
        .duration = "Duration",
        .dynamic_speed = "DynamicSpeed",
        .functional_classification = "FunctionalClassification",
        .geometry_offset = "GeometryOffset",
        .incidents = "Incidents",
        .names = "Names",
        .pedestrian_access = "PedestrianAccess",
        .region = "Region",
        .road_attributes = "RoadAttributes",
        .route_numbers = "RouteNumbers",
        .speed_limit = "SpeedLimit",
        .typical_duration = "TypicalDuration",
    };
};

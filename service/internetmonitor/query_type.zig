pub const QueryType = enum {
    measurements,
    top_locations,
    top_location_details,
    overall_traffic_suggestions,
    overall_traffic_suggestions_details,
    routing_suggestions,

    pub const json_field_names = .{
        .measurements = "MEASUREMENTS",
        .top_locations = "TOP_LOCATIONS",
        .top_location_details = "TOP_LOCATION_DETAILS",
        .overall_traffic_suggestions = "OVERALL_TRAFFIC_SUGGESTIONS",
        .overall_traffic_suggestions_details = "OVERALL_TRAFFIC_SUGGESTIONS_DETAILS",
        .routing_suggestions = "ROUTING_SUGGESTIONS",
    };
};

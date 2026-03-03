const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .measurements => "MEASUREMENTS",
            .top_locations => "TOP_LOCATIONS",
            .top_location_details => "TOP_LOCATION_DETAILS",
            .overall_traffic_suggestions => "OVERALL_TRAFFIC_SUGGESTIONS",
            .overall_traffic_suggestions_details => "OVERALL_TRAFFIC_SUGGESTIONS_DETAILS",
            .routing_suggestions => "ROUTING_SUGGESTIONS",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

const std = @import("std");

pub const RouteResponseNoticeCode = enum {
    main_language_not_found,
    other,
    travel_time_exceeds_driver_work_hours,
    transit_data_unavailable,
    transit_route_unavailable,
    no_transit_stations_found,

    pub const json_field_names = .{
        .main_language_not_found = "MainLanguageNotFound",
        .other = "Other",
        .travel_time_exceeds_driver_work_hours = "TravelTimeExceedsDriverWorkHours",
        .transit_data_unavailable = "TransitDataUnavailable",
        .transit_route_unavailable = "TransitRouteUnavailable",
        .no_transit_stations_found = "NoTransitStationsFound",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .main_language_not_found => "MainLanguageNotFound",
            .other => "Other",
            .travel_time_exceeds_driver_work_hours => "TravelTimeExceedsDriverWorkHours",
            .transit_data_unavailable => "TransitDataUnavailable",
            .transit_route_unavailable => "TransitRouteUnavailable",
            .no_transit_stations_found => "NoTransitStationsFound",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

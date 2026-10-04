const std = @import("std");

pub const RouteTransitIncidentEffect = enum {
    delayed,
    detoured,
    other,
    service_added,
    service_cancelled,
    service_modified,
    service_reduced,
    stop_moved,

    pub const json_field_names = .{
        .delayed = "Delayed",
        .detoured = "Detoured",
        .other = "Other",
        .service_added = "ServiceAdded",
        .service_cancelled = "ServiceCancelled",
        .service_modified = "ServiceModified",
        .service_reduced = "ServiceReduced",
        .stop_moved = "StopMoved",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delayed => "Delayed",
            .detoured => "Detoured",
            .other => "Other",
            .service_added => "ServiceAdded",
            .service_cancelled => "ServiceCancelled",
            .service_modified => "ServiceModified",
            .service_reduced => "ServiceReduced",
            .stop_moved => "StopMoved",
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

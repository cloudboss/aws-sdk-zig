const std = @import("std");

pub const ExecutionStatusCode = enum {
    initiation_in_process,
    query_queued,
    query_in_process,
    query_failure,
    delivery_in_process,
    delivery_success,
    delivery_failure,

    pub const json_field_names = .{
        .initiation_in_process = "INITIATION_IN_PROCESS",
        .query_queued = "QUERY_QUEUED",
        .query_in_process = "QUERY_IN_PROCESS",
        .query_failure = "QUERY_FAILURE",
        .delivery_in_process = "DELIVERY_IN_PROCESS",
        .delivery_success = "DELIVERY_SUCCESS",
        .delivery_failure = "DELIVERY_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initiation_in_process => "INITIATION_IN_PROCESS",
            .query_queued => "QUERY_QUEUED",
            .query_in_process => "QUERY_IN_PROCESS",
            .query_failure => "QUERY_FAILURE",
            .delivery_in_process => "DELIVERY_IN_PROCESS",
            .delivery_success => "DELIVERY_SUCCESS",
            .delivery_failure => "DELIVERY_FAILURE",
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

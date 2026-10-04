const std = @import("std");

pub const IntermediateTableVersionStatus = enum {
    populate_started,
    populate_success,
    populate_failed,
    retention_period_expired,

    pub const json_field_names = .{
        .populate_started = "POPULATE_STARTED",
        .populate_success = "POPULATE_SUCCESS",
        .populate_failed = "POPULATE_FAILED",
        .retention_period_expired = "RETENTION_PERIOD_EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .populate_started => "POPULATE_STARTED",
            .populate_success => "POPULATE_SUCCESS",
            .populate_failed => "POPULATE_FAILED",
            .retention_period_expired => "RETENTION_PERIOD_EXPIRED",
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

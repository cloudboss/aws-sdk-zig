const std = @import("std");

pub const RetryBuildBatchType = enum {
    retry_all_builds,
    retry_failed_builds,

    pub const json_field_names = .{
        .retry_all_builds = "RETRY_ALL_BUILDS",
        .retry_failed_builds = "RETRY_FAILED_BUILDS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .retry_all_builds => "RETRY_ALL_BUILDS",
            .retry_failed_builds => "RETRY_FAILED_BUILDS",
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

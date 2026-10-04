const std = @import("std");

pub const RequestThrottledExceptionReason = enum {
    account_throttled,
    dependency_request_throttled,
    resource_level_throttle,

    pub const json_field_names = .{
        .account_throttled = "ACCOUNT_THROTTLED",
        .dependency_request_throttled = "DEPENDENCY_REQUEST_THROTTLED",
        .resource_level_throttle = "RESOURCE_LEVEL_THROTTLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_throttled => "ACCOUNT_THROTTLED",
            .dependency_request_throttled => "DEPENDENCY_REQUEST_THROTTLED",
            .resource_level_throttle => "RESOURCE_LEVEL_THROTTLE",
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

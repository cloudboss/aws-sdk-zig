const std = @import("std");

pub const AutoScalingPolicyStateChangeReasonCode = enum {
    user_request,
    provision_failure,
    cleanup_failure,

    pub const json_field_names = .{
        .user_request = "USER_REQUEST",
        .provision_failure = "PROVISION_FAILURE",
        .cleanup_failure = "CLEANUP_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_request => "USER_REQUEST",
            .provision_failure => "PROVISION_FAILURE",
            .cleanup_failure => "CLEANUP_FAILURE",
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

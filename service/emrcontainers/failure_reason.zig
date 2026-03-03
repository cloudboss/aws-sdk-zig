const std = @import("std");

pub const FailureReason = enum {
    internal_error,
    user_error,
    validation_error,
    cluster_unavailable,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .user_error = "USER_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .cluster_unavailable = "CLUSTER_UNAVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "INTERNAL_ERROR",
            .user_error => "USER_ERROR",
            .validation_error => "VALIDATION_ERROR",
            .cluster_unavailable => "CLUSTER_UNAVAILABLE",
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

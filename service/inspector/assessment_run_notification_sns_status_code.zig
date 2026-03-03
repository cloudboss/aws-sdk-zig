const std = @import("std");

pub const AssessmentRunNotificationSnsStatusCode = enum {
    success,
    topic_does_not_exist,
    access_denied,
    internal_error,

    pub const json_field_names = .{
        .success = "SUCCESS",
        .topic_does_not_exist = "TOPIC_DOES_NOT_EXIST",
        .access_denied = "ACCESS_DENIED",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .success => "SUCCESS",
            .topic_does_not_exist => "TOPIC_DOES_NOT_EXIST",
            .access_denied => "ACCESS_DENIED",
            .internal_error => "INTERNAL_ERROR",
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

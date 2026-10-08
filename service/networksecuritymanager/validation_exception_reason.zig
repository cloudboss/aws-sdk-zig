const std = @import("std");

pub const ValidationExceptionReason = enum {
    account_not_onboarded,
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .account_not_onboarded = "ACCOUNT_NOT_ONBOARDED",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .account_not_onboarded => "ACCOUNT_NOT_ONBOARDED",
            .field_validation_failed => "FIELD_VALIDATION_FAILED",
            .other => "OTHER",
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

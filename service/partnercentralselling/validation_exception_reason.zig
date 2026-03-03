const std = @import("std");

pub const ValidationExceptionReason = enum {
    request_validation_failed,
    business_validation_failed,

    pub const json_field_names = .{
        .request_validation_failed = "REQUEST_VALIDATION_FAILED",
        .business_validation_failed = "BUSINESS_VALIDATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .request_validation_failed => "REQUEST_VALIDATION_FAILED",
            .business_validation_failed => "BUSINESS_VALIDATION_FAILED",
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

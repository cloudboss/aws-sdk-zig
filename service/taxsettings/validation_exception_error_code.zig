const std = @import("std");

pub const ValidationExceptionErrorCode = enum {
    malformed_token,
    expired_token,
    invalid_token,
    field_validation_failed,
    missing_input,

    pub const json_field_names = .{
        .malformed_token = "MalformedToken",
        .expired_token = "ExpiredToken",
        .invalid_token = "InvalidToken",
        .field_validation_failed = "FieldValidationFailed",
        .missing_input = "MissingInput",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .malformed_token => "MalformedToken",
            .expired_token => "ExpiredToken",
            .invalid_token => "InvalidToken",
            .field_validation_failed => "FieldValidationFailed",
            .missing_input => "MissingInput",
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

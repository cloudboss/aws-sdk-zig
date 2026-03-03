const std = @import("std");

pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    other,
    business_validation_failed,

    pub const json_field_names = .{
        .unknown_operation = "unknownOperation",
        .cannot_parse = "cannotParse",
        .field_validation_failed = "fieldValidationFailed",
        .other = "other",
        .business_validation_failed = "BUSINESS_VALIDATION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown_operation => "unknownOperation",
            .cannot_parse => "cannotParse",
            .field_validation_failed => "fieldValidationFailed",
            .other => "other",
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

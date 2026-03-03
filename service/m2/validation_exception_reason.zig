const std = @import("std");

pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    feature_not_available,
    unsupported_engine_version,
    field_validation_failed,
    other,

    pub const json_field_names = .{
        .unknown_operation = "unknownOperation",
        .cannot_parse = "cannotParse",
        .feature_not_available = "featureNotAvailable",
        .unsupported_engine_version = "unsupportedEngineVersion",
        .field_validation_failed = "fieldValidationFailed",
        .other = "other",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown_operation => "unknownOperation",
            .cannot_parse => "cannotParse",
            .feature_not_available => "featureNotAvailable",
            .unsupported_engine_version => "unsupportedEngineVersion",
            .field_validation_failed => "fieldValidationFailed",
            .other => "other",
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

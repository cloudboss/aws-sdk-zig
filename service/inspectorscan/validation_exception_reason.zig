const std = @import("std");

pub const ValidationExceptionReason = enum {
    unknown_operation,
    cannot_parse,
    field_validation_failed,
    unsupported_sbom_type,
    other,

    pub const json_field_names = .{
        .unknown_operation = "UNKNOWN_OPERATION",
        .cannot_parse = "CANNOT_PARSE",
        .field_validation_failed = "FIELD_VALIDATION_FAILED",
        .unsupported_sbom_type = "UNSUPPORTED_SBOM_TYPE",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown_operation => "UNKNOWN_OPERATION",
            .cannot_parse => "CANNOT_PARSE",
            .field_validation_failed => "FIELD_VALIDATION_FAILED",
            .unsupported_sbom_type => "UNSUPPORTED_SBOM_TYPE",
            .other => "OTHER",
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

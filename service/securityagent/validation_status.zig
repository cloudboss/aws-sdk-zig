const std = @import("std");

/// Per-finding sandbox validation status
pub const ValidationStatus = enum {
    confirmed,
    not_reproduced,
    validation_failed,
    validating,
    not_validated,

    pub const json_field_names = .{
        .confirmed = "CONFIRMED",
        .not_reproduced = "NOT_REPRODUCED",
        .validation_failed = "VALIDATION_FAILED",
        .validating = "VALIDATING",
        .not_validated = "NOT_VALIDATED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .confirmed => "CONFIRMED",
            .not_reproduced => "NOT_REPRODUCED",
            .validation_failed => "VALIDATION_FAILED",
            .validating => "VALIDATING",
            .not_validated => "NOT_VALIDATED",
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

const std = @import("std");

pub const ValidationExceptionReason = enum {
    field_validation_failed,
    invalid_status,
    guardrail_intervened,

    pub const json_field_names = .{
        .field_validation_failed = "FieldValidationFailed",
        .invalid_status = "InvalidStatus",
        .guardrail_intervened = "GuardrailIntervened",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .field_validation_failed => "FieldValidationFailed",
            .invalid_status => "InvalidStatus",
            .guardrail_intervened => "GuardrailIntervened",
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

const std = @import("std");

pub const ValidationExceptionReason = enum {
    cannot_parse,
    field_validation_failed,
    idempotent_parameter_mismatch_exception,
    root_event_in_other_session,
    resource_conflict,

    pub const json_field_names = .{
        .cannot_parse = "CannotParse",
        .field_validation_failed = "FieldValidationFailed",
        .idempotent_parameter_mismatch_exception = "IdempotentParameterMismatchException",
        .root_event_in_other_session = "EventInOtherSession",
        .resource_conflict = "ResourceConflict",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cannot_parse => "CannotParse",
            .field_validation_failed => "FieldValidationFailed",
            .idempotent_parameter_mismatch_exception => "IdempotentParameterMismatchException",
            .root_event_in_other_session => "EventInOtherSession",
            .resource_conflict => "ResourceConflict",
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

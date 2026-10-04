const std = @import("std");

pub const ValidationExceptionReason = enum {
    /// No such operation is supported.
    unknown_operation,
    /// The required input is missing.
    missing,
    cannot_parse,
    field_validation_failed,
    /// The input is invalid but no more specific reason is applicable.
    other,
    /// No such field is supported.
    unknown_field,

    pub const json_field_names = .{
        .unknown_operation = "UnknownOperation",
        .missing = "Missing",
        .cannot_parse = "CannotParse",
        .field_validation_failed = "FieldValidationFailed",
        .other = "Other",
        .unknown_field = "UnknownField",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown_operation => "UnknownOperation",
            .missing => "Missing",
            .cannot_parse => "CannotParse",
            .field_validation_failed => "FieldValidationFailed",
            .other => "Other",
            .unknown_field => "UnknownField",
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

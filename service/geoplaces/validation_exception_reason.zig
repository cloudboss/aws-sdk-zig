const std = @import("std");

pub const ValidationExceptionReason = enum {
    /// No such operation is supported.
    unknown_operation,
    /// The required input is missing.
    missing,
    /// The input cannot be parsed. For example a required JSON document, ARN
    /// identifier,
    /// date value, or numeric field cannot be parsed.
    cannot_parse,
    /// The input is present and parsable, but it is otherwise invalid. For example,
    /// a
    /// required numeric argument is outside the allowed range.
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

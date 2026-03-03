const std = @import("std");

pub const FieldValidationCode = enum {
    required_field_missing,
    duplicate_value,
    invalid_value,
    invalid_string_format,
    too_many_values,
    action_not_permitted,
    invalid_enum_value,

    pub const json_field_names = .{
        .required_field_missing = "REQUIRED_FIELD_MISSING",
        .duplicate_value = "DUPLICATE_VALUE",
        .invalid_value = "INVALID_VALUE",
        .invalid_string_format = "INVALID_STRING_FORMAT",
        .too_many_values = "TOO_MANY_VALUES",
        .action_not_permitted = "ACTION_NOT_PERMITTED",
        .invalid_enum_value = "INVALID_ENUM_VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .required_field_missing => "REQUIRED_FIELD_MISSING",
            .duplicate_value => "DUPLICATE_VALUE",
            .invalid_value => "INVALID_VALUE",
            .invalid_string_format => "INVALID_STRING_FORMAT",
            .too_many_values => "TOO_MANY_VALUES",
            .action_not_permitted => "ACTION_NOT_PERMITTED",
            .invalid_enum_value => "INVALID_ENUM_VALUE",
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

const std = @import("std");

pub const ValidationExceptionErrorCode = enum {
    required_field_missing,
    invalid_enum_value,
    invalid_string_format,
    invalid_value,
    not_enough_values,
    too_many_values,
    invalid_resource_state,
    duplicate_key_value,
    value_out_of_range,
    action_not_permitted,

    pub const json_field_names = .{
        .required_field_missing = "REQUIRED_FIELD_MISSING",
        .invalid_enum_value = "INVALID_ENUM_VALUE",
        .invalid_string_format = "INVALID_STRING_FORMAT",
        .invalid_value = "INVALID_VALUE",
        .not_enough_values = "NOT_ENOUGH_VALUES",
        .too_many_values = "TOO_MANY_VALUES",
        .invalid_resource_state = "INVALID_RESOURCE_STATE",
        .duplicate_key_value = "DUPLICATE_KEY_VALUE",
        .value_out_of_range = "VALUE_OUT_OF_RANGE",
        .action_not_permitted = "ACTION_NOT_PERMITTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .required_field_missing => "REQUIRED_FIELD_MISSING",
            .invalid_enum_value => "INVALID_ENUM_VALUE",
            .invalid_string_format => "INVALID_STRING_FORMAT",
            .invalid_value => "INVALID_VALUE",
            .not_enough_values => "NOT_ENOUGH_VALUES",
            .too_many_values => "TOO_MANY_VALUES",
            .invalid_resource_state => "INVALID_RESOURCE_STATE",
            .duplicate_key_value => "DUPLICATE_KEY_VALUE",
            .value_out_of_range => "VALUE_OUT_OF_RANGE",
            .action_not_permitted => "ACTION_NOT_PERMITTED",
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

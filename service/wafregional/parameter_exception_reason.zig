const std = @import("std");

pub const ParameterExceptionReason = enum {
    invalid_option,
    illegal_combination,
    illegal_argument,
    invalid_tag_key,

    pub const json_field_names = .{
        .invalid_option = "INVALID_OPTION",
        .illegal_combination = "ILLEGAL_COMBINATION",
        .illegal_argument = "ILLEGAL_ARGUMENT",
        .invalid_tag_key = "INVALID_TAG_KEY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_option => "INVALID_OPTION",
            .illegal_combination => "ILLEGAL_COMBINATION",
            .illegal_argument => "ILLEGAL_ARGUMENT",
            .invalid_tag_key => "INVALID_TAG_KEY",
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

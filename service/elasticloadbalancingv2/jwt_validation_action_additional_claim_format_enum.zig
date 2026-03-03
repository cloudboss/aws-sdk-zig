const std = @import("std");

pub const JwtValidationActionAdditionalClaimFormatEnum = enum {
    single_string,
    string_array,
    space_separated_values,

    pub const json_field_names = .{
        .single_string = "single-string",
        .string_array = "string-array",
        .space_separated_values = "space-separated-values",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_string => "single-string",
            .string_array => "string-array",
            .space_separated_values => "space-separated-values",
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

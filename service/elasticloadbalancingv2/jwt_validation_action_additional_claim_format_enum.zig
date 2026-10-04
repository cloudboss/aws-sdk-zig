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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};

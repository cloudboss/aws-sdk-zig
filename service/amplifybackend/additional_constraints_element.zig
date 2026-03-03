const std = @import("std");

pub const AdditionalConstraintsElement = enum {
    require_digit,
    require_lowercase,
    require_symbol,
    require_uppercase,

    pub const json_field_names = .{
        .require_digit = "REQUIRE_DIGIT",
        .require_lowercase = "REQUIRE_LOWERCASE",
        .require_symbol = "REQUIRE_SYMBOL",
        .require_uppercase = "REQUIRE_UPPERCASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .require_digit => "REQUIRE_DIGIT",
            .require_lowercase => "REQUIRE_LOWERCASE",
            .require_symbol => "REQUIRE_SYMBOL",
            .require_uppercase => "REQUIRE_UPPERCASE",
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

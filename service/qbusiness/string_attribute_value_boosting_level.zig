const std = @import("std");

pub const StringAttributeValueBoostingLevel = enum {
    low,
    medium,
    high,
    very_high,
    one,
    two,
    three,
    four,
    five,

    pub const json_field_names = .{
        .low = "LOW",
        .medium = "MEDIUM",
        .high = "HIGH",
        .very_high = "VERY_HIGH",
        .one = "ONE",
        .two = "TWO",
        .three = "THREE",
        .four = "FOUR",
        .five = "FIVE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .low => "LOW",
            .medium => "MEDIUM",
            .high => "HIGH",
            .very_high => "VERY_HIGH",
            .one => "ONE",
            .two => "TWO",
            .three => "THREE",
            .four => "FOUR",
            .five => "FIVE",
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

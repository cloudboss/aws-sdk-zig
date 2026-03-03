const std = @import("std");

pub const StrategyRecommendation = enum {
    recommended,
    viable_option,
    not_recommended,
    potential,

    pub const json_field_names = .{
        .recommended = "recommended",
        .viable_option = "viableOption",
        .not_recommended = "notRecommended",
        .potential = "potential",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .recommended => "recommended",
            .viable_option => "viableOption",
            .not_recommended => "notRecommended",
            .potential => "potential",
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

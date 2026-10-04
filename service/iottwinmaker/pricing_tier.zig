const std = @import("std");

pub const PricingTier = enum {
    tier_1,
    tier_2,
    tier_3,
    tier_4,

    pub const json_field_names = .{
        .tier_1 = "TIER_1",
        .tier_2 = "TIER_2",
        .tier_3 = "TIER_3",
        .tier_4 = "TIER_4",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tier_1 => "TIER_1",
            .tier_2 => "TIER_2",
            .tier_3 => "TIER_3",
            .tier_4 => "TIER_4",
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

const std = @import("std");

pub const RequestBillingMode = enum {
    pay_as_you_go,
    flat_rate_tier_1,
    flat_rate_tier_2,
    flat_rate_tier_3,
    flat_rate_tier_4,
    flat_rate_tier_5,

    pub const json_field_names = .{
        .pay_as_you_go = "PayAsYouGo",
        .flat_rate_tier_1 = "FlatRateTier1",
        .flat_rate_tier_2 = "FlatRateTier2",
        .flat_rate_tier_3 = "FlatRateTier3",
        .flat_rate_tier_4 = "FlatRateTier4",
        .flat_rate_tier_5 = "FlatRateTier5",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pay_as_you_go => "PayAsYouGo",
            .flat_rate_tier_1 => "FlatRateTier1",
            .flat_rate_tier_2 => "FlatRateTier2",
            .flat_rate_tier_3 => "FlatRateTier3",
            .flat_rate_tier_4 => "FlatRateTier4",
            .flat_rate_tier_5 => "FlatRateTier5",
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

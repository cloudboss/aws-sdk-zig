const std = @import("std");

pub const ProvisionedControlPlaneTier = enum {
    standard,
    tier_xl,
    tier_2_xl,
    tier_4_xl,
    tier_8_xl,

    pub const json_field_names = .{
        .standard = "standard",
        .tier_xl = "tier-xl",
        .tier_2_xl = "tier-2xl",
        .tier_4_xl = "tier-4xl",
        .tier_8_xl = "tier-8xl",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "standard",
            .tier_xl => "tier-xl",
            .tier_2_xl => "tier-2xl",
            .tier_4_xl => "tier-4xl",
            .tier_8_xl => "tier-8xl",
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

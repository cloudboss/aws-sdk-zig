const std = @import("std");

pub const UpdateReason = enum {
    default,
    pricing_tier_update,
    entity_count_update,
    pricing_mode_update,
    overwritten,

    pub const json_field_names = .{
        .default = "DEFAULT",
        .pricing_tier_update = "PRICING_TIER_UPDATE",
        .entity_count_update = "ENTITY_COUNT_UPDATE",
        .pricing_mode_update = "PRICING_MODE_UPDATE",
        .overwritten = "OVERWRITTEN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .default => "DEFAULT",
            .pricing_tier_update => "PRICING_TIER_UPDATE",
            .entity_count_update => "ENTITY_COUNT_UPDATE",
            .pricing_mode_update => "PRICING_MODE_UPDATE",
            .overwritten => "OVERWRITTEN",
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

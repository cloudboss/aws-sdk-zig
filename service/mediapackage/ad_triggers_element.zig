const std = @import("std");

pub const __AdTriggersElement = enum {
    splice_insert,
    @"break",
    provider_advertisement,
    distributor_advertisement,
    provider_placement_opportunity,
    distributor_placement_opportunity,
    provider_overlay_placement_opportunity,
    distributor_overlay_placement_opportunity,

    pub const json_field_names = .{
        .splice_insert = "SPLICE_INSERT",
        .@"break" = "BREAK",
        .provider_advertisement = "PROVIDER_ADVERTISEMENT",
        .distributor_advertisement = "DISTRIBUTOR_ADVERTISEMENT",
        .provider_placement_opportunity = "PROVIDER_PLACEMENT_OPPORTUNITY",
        .distributor_placement_opportunity = "DISTRIBUTOR_PLACEMENT_OPPORTUNITY",
        .provider_overlay_placement_opportunity = "PROVIDER_OVERLAY_PLACEMENT_OPPORTUNITY",
        .distributor_overlay_placement_opportunity = "DISTRIBUTOR_OVERLAY_PLACEMENT_OPPORTUNITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .splice_insert => "SPLICE_INSERT",
            .@"break" => "BREAK",
            .provider_advertisement => "PROVIDER_ADVERTISEMENT",
            .distributor_advertisement => "DISTRIBUTOR_ADVERTISEMENT",
            .provider_placement_opportunity => "PROVIDER_PLACEMENT_OPPORTUNITY",
            .distributor_placement_opportunity => "DISTRIBUTOR_PLACEMENT_OPPORTUNITY",
            .provider_overlay_placement_opportunity => "PROVIDER_OVERLAY_PLACEMENT_OPPORTUNITY",
            .distributor_overlay_placement_opportunity => "DISTRIBUTOR_OVERLAY_PLACEMENT_OPPORTUNITY",
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

const std = @import("std");

pub const PurchaseOptionBadgeType = enum {
    private_pricing,
    future_dated,
    replacement_offer,
    auto_renew,

    pub const json_field_names = .{
        .private_pricing = "PRIVATE_PRICING",
        .future_dated = "FUTURE_DATED",
        .replacement_offer = "REPLACEMENT_OFFER",
        .auto_renew = "AUTO_RENEW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .private_pricing => "PRIVATE_PRICING",
            .future_dated => "FUTURE_DATED",
            .replacement_offer => "REPLACEMENT_OFFER",
            .auto_renew => "AUTO_RENEW",
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

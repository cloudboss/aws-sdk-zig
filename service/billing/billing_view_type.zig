const std = @import("std");

pub const BillingViewType = enum {
    primary,
    billing_group,
    custom,
    billing_transfer,
    billing_transfer_showback,

    pub const json_field_names = .{
        .primary = "PRIMARY",
        .billing_group = "BILLING_GROUP",
        .custom = "CUSTOM",
        .billing_transfer = "BILLING_TRANSFER",
        .billing_transfer_showback = "BILLING_TRANSFER_SHOWBACK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary => "PRIMARY",
            .billing_group => "BILLING_GROUP",
            .custom => "CUSTOM",
            .billing_transfer => "BILLING_TRANSFER",
            .billing_transfer_showback => "BILLING_TRANSFER_SHOWBACK",
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

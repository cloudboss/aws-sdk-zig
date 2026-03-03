const std = @import("std");

pub const AddressRoleType = enum {
    tax_address,
    billing_address,
    contact_address,

    pub const json_field_names = .{
        .tax_address = "TaxAddress",
        .billing_address = "BillingAddress",
        .contact_address = "ContactAddress",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tax_address => "TaxAddress",
            .billing_address => "BillingAddress",
            .contact_address => "ContactAddress",
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

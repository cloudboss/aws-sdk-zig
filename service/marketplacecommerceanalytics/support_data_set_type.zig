const std = @import("std");

pub const SupportDataSetType = enum {
    customer_support_contacts_data,
    test_customer_support_contacts_data,

    pub const json_field_names = .{
        .customer_support_contacts_data = "customer_support_contacts_data",
        .test_customer_support_contacts_data = "test_customer_support_contacts_data",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .customer_support_contacts_data => "customer_support_contacts_data",
            .test_customer_support_contacts_data => "test_customer_support_contacts_data",
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

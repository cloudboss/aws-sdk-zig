const std = @import("std");

pub const AddressType = enum {
    shipping_address,
    operating_address,

    pub const json_field_names = .{
        .shipping_address = "SHIPPING_ADDRESS",
        .operating_address = "OPERATING_ADDRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .shipping_address => "SHIPPING_ADDRESS",
            .operating_address => "OPERATING_ADDRESS",
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

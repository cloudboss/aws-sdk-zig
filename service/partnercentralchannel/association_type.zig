const std = @import("std");

pub const AssociationType = enum {
    downstream_seller,
    end_customer,
    internal,

    pub const json_field_names = .{
        .downstream_seller = "DOWNSTREAM_SELLER",
        .end_customer = "END_CUSTOMER",
        .internal = "INTERNAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .downstream_seller => "DOWNSTREAM_SELLER",
            .end_customer => "END_CUSTOMER",
            .internal => "INTERNAL",
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

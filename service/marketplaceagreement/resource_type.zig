const std = @import("std");

pub const ResourceType = enum {
    agreement,
    charge,
    payment_request,

    pub const json_field_names = .{
        .agreement = "Agreement",
        .charge = "Charge",
        .payment_request = "PaymentRequest",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .agreement => "Agreement",
            .charge => "Charge",
            .payment_request => "PaymentRequest",
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

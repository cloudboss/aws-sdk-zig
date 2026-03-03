const std = @import("std");

pub const RevenueModel = enum {
    contract,
    pay_as_you_go,
    subscription,

    pub const json_field_names = .{
        .contract = "Contract",
        .pay_as_you_go = "Pay-as-you-go",
        .subscription = "Subscription",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .contract => "Contract",
            .pay_as_you_go => "Pay-as-you-go",
            .subscription => "Subscription",
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

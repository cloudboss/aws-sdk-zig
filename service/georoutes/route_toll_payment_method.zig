const std = @import("std");

pub const RouteTollPaymentMethod = enum {
    bank_card,
    cash,
    cash_exact,
    credit_card,
    pass_subscription,
    travel_card,
    transponder,
    video_toll,

    pub const json_field_names = .{
        .bank_card = "BankCard",
        .cash = "Cash",
        .cash_exact = "CashExact",
        .credit_card = "CreditCard",
        .pass_subscription = "PassSubscription",
        .travel_card = "TravelCard",
        .transponder = "Transponder",
        .video_toll = "VideoToll",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .bank_card => "BankCard",
            .cash => "Cash",
            .cash_exact => "CashExact",
            .credit_card => "CreditCard",
            .pass_subscription => "PassSubscription",
            .travel_card => "TravelCard",
            .transponder => "Transponder",
            .video_toll => "VideoToll",
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

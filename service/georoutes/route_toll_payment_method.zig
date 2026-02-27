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
        .bank_card = "BANK_CARD",
        .cash = "CASH",
        .cash_exact = "CASH_EXACT",
        .credit_card = "CREDIT_CARD",
        .pass_subscription = "PASS_SUBSCRIPTION",
        .travel_card = "TRAVEL_CARD",
        .transponder = "TRANSPONDER",
        .video_toll = "VIDEO_TOLL",
    };
};

pub const Stage = enum {
    prospect,
    qualified,
    technical_validation,
    business_validation,
    committed,
    launched,
    closed_lost,

    pub const json_field_names = .{
        .prospect = "PROSPECT",
        .qualified = "QUALIFIED",
        .technical_validation = "TECHNICAL_VALIDATION",
        .business_validation = "BUSINESS_VALIDATION",
        .committed = "COMMITTED",
        .launched = "LAUNCHED",
        .closed_lost = "CLOSED_LOST",
    };
};

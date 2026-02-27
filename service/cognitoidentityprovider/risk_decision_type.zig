pub const RiskDecisionType = enum {
    no_risk,
    account_takeover,
    block,

    pub const json_field_names = .{
        .no_risk = "NoRisk",
        .account_takeover = "AccountTakeover",
        .block = "Block",
    };
};

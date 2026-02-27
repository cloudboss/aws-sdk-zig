pub const UseCaseType = enum {
    rules_evaluation,
    connect_campaigns,

    pub const json_field_names = .{
        .rules_evaluation = "RULES_EVALUATION",
        .connect_campaigns = "CONNECT_CAMPAIGNS",
    };
};

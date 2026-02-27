pub const LambdaSavingsEstimationModeSource = enum {
    public_pricing,
    cost_explorer_rightsizing,
    cost_optimization_hub,

    pub const json_field_names = .{
        .public_pricing = "PUBLIC_PRICING",
        .cost_explorer_rightsizing = "COST_EXPLORER_RIGHTSIZING",
        .cost_optimization_hub = "COST_OPTIMIZATION_HUB",
    };
};

pub const Source = enum {
    compute_optimizer,
    cost_explorer,

    pub const json_field_names = .{
        .compute_optimizer = "COMPUTE_OPTIMIZER",
        .cost_explorer = "COST_EXPLORER",
    };
};

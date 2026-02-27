pub const RuleOrder = enum {
    strict_order,
    default_action_order,

    pub const json_field_names = .{
        .strict_order = "STRICT_ORDER",
        .default_action_order = "DEFAULT_ACTION_ORDER",
    };
};

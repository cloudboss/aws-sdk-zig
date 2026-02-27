pub const RuleOrder = enum {
    default_action_order,
    strict_order,

    pub const json_field_names = .{
        .default_action_order = "DEFAULT_ACTION_ORDER",
        .strict_order = "STRICT_ORDER",
    };
};

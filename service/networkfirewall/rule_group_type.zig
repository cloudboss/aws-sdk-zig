pub const RuleGroupType = enum {
    stateless,
    stateful,

    pub const json_field_names = .{
        .stateless = "STATELESS",
        .stateful = "STATEFUL",
    };
};

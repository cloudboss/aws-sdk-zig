pub const EventTriggerLogicalOperator = enum {
    any,
    all,
    none,

    pub const json_field_names = .{
        .any = "ANY",
        .all = "ALL",
        .none = "NONE",
    };
};

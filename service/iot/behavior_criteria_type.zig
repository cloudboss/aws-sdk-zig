pub const BehaviorCriteriaType = enum {
    static,
    statistical,
    machine_learning,

    pub const json_field_names = .{
        .static = "STATIC",
        .statistical = "STATISTICAL",
        .machine_learning = "MACHINE_LEARNING",
    };
};

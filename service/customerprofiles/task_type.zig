pub const TaskType = enum {
    arithmetic,
    filter,
    map,
    mask,
    merge,
    truncate,
    validate,

    pub const json_field_names = .{
        .arithmetic = "ARITHMETIC",
        .filter = "FILTER",
        .map = "MAP",
        .mask = "MASK",
        .merge = "MERGE",
        .truncate = "TRUNCATE",
        .validate = "VALIDATE",
    };
};

pub const TaskType = enum {
    arithmetic,
    filter,
    map,
    map_all,
    mask,
    merge,
    passthrough,
    truncate,
    validate,
    partition,

    pub const json_field_names = .{
        .arithmetic = "ARITHMETIC",
        .filter = "FILTER",
        .map = "MAP",
        .map_all = "MAP_ALL",
        .mask = "MASK",
        .merge = "MERGE",
        .passthrough = "PASSTHROUGH",
        .truncate = "TRUNCATE",
        .validate = "VALIDATE",
        .partition = "PARTITION",
    };
};

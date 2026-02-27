pub const ColumnOrderingType = enum {
    greater_is_better,
    lesser_is_better,
    specified,

    pub const json_field_names = .{
        .greater_is_better = "GREATER_IS_BETTER",
        .lesser_is_better = "LESSER_IS_BETTER",
        .specified = "SPECIFIED",
    };
};

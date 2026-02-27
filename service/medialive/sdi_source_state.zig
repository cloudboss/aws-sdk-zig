/// Used in SdiSource, DescribeNodeRequest, DescribeNodeResult
pub const SdiSourceState = enum {
    idle,
    in_use,
    deleted,

    pub const json_field_names = .{
        .idle = "IDLE",
        .in_use = "IN_USE",
        .deleted = "DELETED",
    };
};

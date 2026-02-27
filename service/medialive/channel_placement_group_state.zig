/// Used in DescribeChannelPlacementGroupResult
pub const ChannelPlacementGroupState = enum {
    unassigned,
    assigning,
    assigned,
    deleting,
    delete_failed,
    deleted,
    unassigning,

    pub const json_field_names = .{
        .unassigned = "UNASSIGNED",
        .assigning = "ASSIGNING",
        .assigned = "ASSIGNED",
        .deleting = "DELETING",
        .delete_failed = "DELETE_FAILED",
        .deleted = "DELETED",
        .unassigning = "UNASSIGNING",
    };
};

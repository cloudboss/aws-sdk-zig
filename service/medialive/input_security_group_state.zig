/// Placeholder documentation for InputSecurityGroupState
pub const InputSecurityGroupState = enum {
    idle,
    in_use,
    updating,
    deleted,

    pub const json_field_names = .{
        .idle = "IDLE",
        .in_use = "IN_USE",
        .updating = "UPDATING",
        .deleted = "DELETED",
    };
};

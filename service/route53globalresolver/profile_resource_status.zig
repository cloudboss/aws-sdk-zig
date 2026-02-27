pub const ProfileResourceStatus = enum {
    creating,
    operational,
    updating,
    enabling,
    disabling,
    disabled,
    deleting,

    pub const json_field_names = .{
        .creating = "CREATING",
        .operational = "OPERATIONAL",
        .updating = "UPDATING",
        .enabling = "ENABLING",
        .disabling = "DISABLING",
        .disabled = "DISABLED",
        .deleting = "DELETING",
    };
};

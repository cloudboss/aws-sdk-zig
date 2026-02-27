pub const VersionStatus = enum {
    /// The Version is being created
    creating,
    /// The Version is updating
    updating,
    /// The Version is deleting
    deleting,
    /// The Version is active
    active,
    /// The Version creation failed
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};

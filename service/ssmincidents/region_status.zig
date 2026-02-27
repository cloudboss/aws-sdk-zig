pub const RegionStatus = enum {
    /// All operations have completed successfully and the region is ready to use
    active,
    /// The region is in the process of being created.
    creating,
    /// The region is in the process of being deleted.
    deleting,
    /// The region is not healthy and we cannot automatically fix it.
    failed,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
        .failed = "FAILED",
    };
};

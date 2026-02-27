pub const StoreStatus = enum {
    /// The Store is being created
    creating,
    /// The Store is updating
    updating,
    /// The Store is deleting
    deleting,
    /// The Store is active
    active,
    /// The Store creation failed
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};

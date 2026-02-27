pub const IndexState = enum {
    /// Resource Explorer is creating the index.
    creating,
    /// Index is active.
    active,
    /// Resource Explorer is deleting the index.
    deleting,
    /// Resource Explorer successfully deleted the index.
    deleted,
    /// Resource Explorer is switching the index type between local and aggregator.
    updating,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .deleted = "DELETED",
        .updating = "UPDATING",
    };
};

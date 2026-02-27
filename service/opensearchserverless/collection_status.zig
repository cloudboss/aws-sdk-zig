pub const CollectionStatus = enum {
    /// Creating collection resource
    creating,
    /// Deleting collection resource
    deleting,
    /// Collection resource is ready to use
    active,
    /// Collection resource create or delete failed
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .deleting = "DELETING",
        .active = "ACTIVE",
        .failed = "FAILED",
    };
};

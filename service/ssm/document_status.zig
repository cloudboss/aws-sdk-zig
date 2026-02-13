/// The status of a document.
pub const DocumentStatus = enum {
    creating,
    active,
    updating,
    deleting,
    failed,

    pub const json_field_names = .{
        .creating = "Creating",
        .active = "Active",
        .updating = "Updating",
        .deleting = "Deleting",
        .failed = "Failed",
    };
};

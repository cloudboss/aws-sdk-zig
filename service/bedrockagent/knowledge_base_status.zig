pub const KnowledgeBaseStatus = enum {
    creating,
    active,
    deleting,
    updating,
    failed,
    delete_unsuccessful,

    pub const json_field_names = .{
        .creating = "CREATING",
        .active = "ACTIVE",
        .deleting = "DELETING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .delete_unsuccessful = "DELETE_UNSUCCESSFUL",
    };
};

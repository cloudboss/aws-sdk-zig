pub const ModelVariantStatus = enum {
    creating,
    updating,
    in_service,
    deleting,
    deleted,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .in_service = "IN_SERVICE",
        .deleting = "DELETING",
        .deleted = "DELETED",
    };
};

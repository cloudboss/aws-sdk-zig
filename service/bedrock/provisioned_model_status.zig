pub const ProvisionedModelStatus = enum {
    creating,
    in_service,
    updating,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .in_service = "IN_SERVICE",
        .updating = "UPDATING",
        .failed = "FAILED",
    };
};

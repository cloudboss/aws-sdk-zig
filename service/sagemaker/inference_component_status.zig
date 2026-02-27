pub const InferenceComponentStatus = enum {
    in_service,
    creating,
    updating,
    failed,
    deleting,

    pub const json_field_names = .{
        .in_service = "IN_SERVICE",
        .creating = "CREATING",
        .updating = "UPDATING",
        .failed = "FAILED",
        .deleting = "DELETING",
    };
};

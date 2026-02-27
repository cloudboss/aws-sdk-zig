pub const GatewayStatus = enum {
    creating,
    updating,
    update_unsuccessful,
    deleting,
    ready,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .updating = "UPDATING",
        .update_unsuccessful = "UPDATE_UNSUCCESSFUL",
        .deleting = "DELETING",
        .ready = "READY",
        .failed = "FAILED",
    };
};

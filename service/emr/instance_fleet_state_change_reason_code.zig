pub const InstanceFleetStateChangeReasonCode = enum {
    internal_error,
    validation_error,
    instance_failure,
    cluster_terminated,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .instance_failure = "INSTANCE_FAILURE",
        .cluster_terminated = "CLUSTER_TERMINATED",
    };
};

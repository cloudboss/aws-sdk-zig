pub const FailureReason = enum {
    internal_error,
    user_error,
    validation_error,
    cluster_unavailable,

    pub const json_field_names = .{
        .internal_error = "INTERNAL_ERROR",
        .user_error = "USER_ERROR",
        .validation_error = "VALIDATION_ERROR",
        .cluster_unavailable = "CLUSTER_UNAVAILABLE",
    };
};

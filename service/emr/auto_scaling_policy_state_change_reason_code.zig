pub const AutoScalingPolicyStateChangeReasonCode = enum {
    user_request,
    provision_failure,
    cleanup_failure,

    pub const json_field_names = .{
        .user_request = "USER_REQUEST",
        .provision_failure = "PROVISION_FAILURE",
        .cleanup_failure = "CLEANUP_FAILURE",
    };
};

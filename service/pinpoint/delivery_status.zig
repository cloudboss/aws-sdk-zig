pub const DeliveryStatus = enum {
    successful,
    throttled,
    temporary_failure,
    permanent_failure,
    unknown_failure,
    opt_out,
    duplicate,

    pub const json_field_names = .{
        .successful = "SUCCESSFUL",
        .throttled = "THROTTLED",
        .temporary_failure = "TEMPORARY_FAILURE",
        .permanent_failure = "PERMANENT_FAILURE",
        .unknown_failure = "UNKNOWN_FAILURE",
        .opt_out = "OPT_OUT",
        .duplicate = "DUPLICATE",
    };
};

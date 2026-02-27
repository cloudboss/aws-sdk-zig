pub const ActiveDirectoryStatus = enum {
    access_denied,
    detached,
    joined,
    joining,
    network_error,
    timeout,
    unknown_error,
    insufficient_permissions,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .detached = "DETACHED",
        .joined = "JOINED",
        .joining = "JOINING",
        .network_error = "NETWORK_ERROR",
        .timeout = "TIMEOUT",
        .unknown_error = "UNKNOWN_ERROR",
        .insufficient_permissions = "INSUFFICIENT_PERMISSIONS",
    };
};

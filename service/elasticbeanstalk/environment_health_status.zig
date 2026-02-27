pub const EnvironmentHealthStatus = enum {
    no_data,
    unknown,
    pending,
    ok,
    info,
    warning,
    degraded,
    severe,
    suspended,
};

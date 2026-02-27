pub const EnvironmentStatus = enum {
    aborting,
    launching,
    updating,
    linking_from,
    linking_to,
    ready,
    terminating,
    terminated,
};

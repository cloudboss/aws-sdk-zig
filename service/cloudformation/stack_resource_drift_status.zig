pub const StackResourceDriftStatus = enum {
    in_sync,
    modified,
    deleted,
    not_checked,
    unknown,
    unsupported,
};

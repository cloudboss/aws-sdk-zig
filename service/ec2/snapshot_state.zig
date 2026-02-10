pub const SnapshotState = enum {
    pending,
    completed,
    @"error",
    recoverable,
    recovering,
};

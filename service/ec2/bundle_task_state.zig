pub const BundleTaskState = enum {
    pending,
    waiting_for_shutdown,
    bundling,
    storing,
    cancelling,
    complete,
    failed,
};

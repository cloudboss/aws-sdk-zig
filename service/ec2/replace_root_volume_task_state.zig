pub const ReplaceRootVolumeTaskState = enum {
    pending,
    in_progress,
    failing,
    succeeded,
    failed,
    failed_detached,
};

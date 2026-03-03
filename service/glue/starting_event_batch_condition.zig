/// The batch condition that started the workflow run. Either the number of
/// events in the batch size arrived,
/// in which case the BatchSize member is non-zero, or the batch window expired,
/// in which case the BatchWindow
/// member is non-zero.
pub const StartingEventBatchCondition = struct {
    /// Number of events in the batch.
    batch_size: ?i32 = null,

    /// Duration of the batch window in seconds.
    batch_window: ?i32 = null,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .batch_window = "BatchWindow",
    };
};

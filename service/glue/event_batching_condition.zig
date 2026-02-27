/// Batch condition that must be met (specified number of events received or
/// batch time window expired)
/// before EventBridge event trigger fires.
pub const EventBatchingCondition = struct {
    /// Number of events that must be received from Amazon EventBridge before
    /// EventBridge event trigger fires.
    batch_size: i32,

    /// Window of time in seconds after which EventBridge event trigger fires.
    /// Window starts when first event is received.
    batch_window: ?i32,

    pub const json_field_names = .{
        .batch_size = "BatchSize",
        .batch_window = "BatchWindow",
    };
};

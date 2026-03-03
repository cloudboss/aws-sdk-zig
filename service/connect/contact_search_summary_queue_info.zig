/// If this contact was queued, this contains information about the queue.
pub const ContactSearchSummaryQueueInfo = struct {
    /// The timestamp when the contact was added to the queue.
    enqueue_timestamp: ?i64 = null,

    /// The unique identifier for the queue.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .enqueue_timestamp = "EnqueueTimestamp",
        .id = "Id",
    };
};

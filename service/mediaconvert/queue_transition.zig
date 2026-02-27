/// Description of the source and destination queues between which the job has
/// moved, along with the timestamp of the move
pub const QueueTransition = struct {
    /// The queue that the job was on after the transition.
    destination_queue: ?[]const u8,

    /// The queue that the job was on before the transition.
    source_queue: ?[]const u8,

    /// The time, in Unix epoch format, that the job moved from the source queue to
    /// the destination queue.
    timestamp: ?i64,

    pub const json_field_names = .{
        .destination_queue = "DestinationQueue",
        .source_queue = "SourceQueue",
        .timestamp = "Timestamp",
    };
};

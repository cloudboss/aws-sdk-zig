/// Information about a queued dataset SPICE ingestion.
pub const QueueInfo = struct {
    /// The ID of the ongoing ingestion. The queued ingestion is waiting for the
    /// ongoing
    /// ingestion to complete.
    queued_ingestion: []const u8,

    /// The ID of the queued ingestion.
    waiting_on_ingestion: []const u8,

    pub const json_field_names = .{
        .queued_ingestion = "QueuedIngestion",
        .waiting_on_ingestion = "WaitingOnIngestion",
    };
};

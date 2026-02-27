/// Contains information about the most recent successful replication update to
/// a destination.
pub const LastSuccessfulReplicatedUpdate = struct {
    /// The S3 location of the metadata that was successfully replicated.
    metadata_location: []const u8,

    /// The timestamp when the replication update completed successfully.
    timestamp: i64,

    pub const json_field_names = .{
        .metadata_location = "metadataLocation",
        .timestamp = "timestamp",
    };
};

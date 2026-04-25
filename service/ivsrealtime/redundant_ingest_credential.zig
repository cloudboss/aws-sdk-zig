/// An object representing a redundant ingest credential.
pub const RedundantIngestCredential = struct {
    /// ID of the participant within the stage.
    participant_id: ?[]const u8 = null,

    /// Ingest-key value.
    stream_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .participant_id = "participantId",
        .stream_key = "streamKey",
    };
};

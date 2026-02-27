/// The ingest domain URL where the source stream should be sent.
pub const IngestEndpoint = struct {
    /// The system-generated unique identifier for the IngestEndpoint.
    id: ?[]const u8,

    /// The ingest domain URL where the source stream should be sent.
    url: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .url = "Url",
    };
};

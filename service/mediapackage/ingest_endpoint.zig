/// An endpoint for ingesting source content for a Channel.
pub const IngestEndpoint = struct {
    /// The system generated unique identifier for the IngestEndpoint
    id: ?[]const u8,

    /// The system generated password for ingest authentication.
    password: ?[]const u8,

    /// The ingest URL to which the source stream should be sent.
    url: ?[]const u8,

    /// The system generated username for ingest authentication.
    username: ?[]const u8,

    pub const json_field_names = .{
        .id = "Id",
        .password = "Password",
        .url = "Url",
        .username = "Username",
    };
};

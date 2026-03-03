/// A validation message associated with a `ValidatePipeline` request in
/// OpenSearch
/// Ingestion.
pub const ValidationMessage = struct {
    /// The validation message.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};

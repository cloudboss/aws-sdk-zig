/// Contains a summary of an ingestion destination.
pub const IngestionDestinationSummary = struct {
    /// The Amazon Resource Name (ARN) of the ingestion destination.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

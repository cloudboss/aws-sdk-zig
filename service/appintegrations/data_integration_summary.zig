/// Summary information about the DataIntegration.
pub const DataIntegrationSummary = struct {
    /// The Amazon Resource Name (ARN) of the DataIntegration.
    arn: ?[]const u8,

    /// The name of the DataIntegration.
    name: ?[]const u8,

    /// The URI of the data source.
    source_uri: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
        .source_uri = "SourceURI",
    };
};

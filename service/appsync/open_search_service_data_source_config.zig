/// Describes an OpenSearch data source configuration.
pub const OpenSearchServiceDataSourceConfig = struct {
    /// The Amazon Web Services Region.
    aws_region: []const u8,

    /// The endpoint.
    endpoint: []const u8,

    pub const json_field_names = .{
        .aws_region = "awsRegion",
        .endpoint = "endpoint",
    };
};

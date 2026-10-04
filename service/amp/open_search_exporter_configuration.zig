/// The configuration for exporting metrics to an Amazon OpenSearch Service
/// domain.
pub const OpenSearchExporterConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon OpenSearch Service domain.
    domain_arn: []const u8,

    pub const json_field_names = .{
        .domain_arn = "domainArn",
    };
};

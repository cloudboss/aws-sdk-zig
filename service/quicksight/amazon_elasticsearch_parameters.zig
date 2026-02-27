/// The parameters for OpenSearch.
pub const AmazonElasticsearchParameters = struct {
    /// The OpenSearch domain.
    domain: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};

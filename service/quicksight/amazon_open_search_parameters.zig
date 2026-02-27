/// The parameters for OpenSearch.
pub const AmazonOpenSearchParameters = struct {
    /// The OpenSearch domain.
    domain: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};

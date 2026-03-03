/// FIPS-compliant endpoint URLs for an OpenSearch Serverless collection. These
/// endpoints ensure all data transmission uses FIPS 140-3 validated
/// cryptographic implementations, meeting federal security requirements for
/// government workloads.
pub const FipsEndpoints = struct {
    /// FIPS-compliant collection endpoint used to submit index, search, and data
    /// upload requests to an OpenSearch Serverless collection. This endpoint uses
    /// FIPS 140-3 validated cryptography and is required for federal government
    /// workloads.
    collection_endpoint: ?[]const u8 = null,

    /// FIPS-compliant endpoint used to access OpenSearch Dashboards. This endpoint
    /// uses FIPS 140-3 validated cryptography and is required for federal
    /// government workloads that need dashboard visualization capabilities.
    dashboard_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .collection_endpoint = "collectionEndpoint",
        .dashboard_endpoint = "dashboardEndpoint",
    };
};

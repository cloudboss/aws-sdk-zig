/// Provides information that defines an OpenSearch endpoint.
pub const ElasticsearchSettings = struct {
    /// The endpoint for the OpenSearch cluster. DMS uses HTTPS if a transport
    /// protocol (http/https) is not specified.
    endpoint_uri: []const u8,

    /// The maximum number of seconds for which DMS retries failed API requests to
    /// the OpenSearch cluster.
    error_retry_duration: ?i32,

    /// The maximum percentage of records that can fail to be written before a full
    /// load
    /// operation stops.
    ///
    /// To avoid early failure, this counter is only effective after 1000 records
    /// are
    /// transferred. OpenSearch also has the concept of error monitoring during the
    /// last 10 minutes of an Observation Window. If transfer of all records fail in
    /// the last 10
    /// minutes, the full load operation stops.
    full_load_error_percentage: ?i32,

    /// The Amazon Resource Name (ARN) used by the service to access the IAM role.
    /// The role must
    /// allow the `iam:PassRole` action.
    service_access_role_arn: []const u8,

    /// Set this option to `true` for DMS to migrate documentation using the
    /// documentation type `_doc`. OpenSearch and an Elasticsearch cluster only
    /// support
    /// the _doc documentation type in versions 7. x and later. The default value is
    /// `false`.
    use_new_mapping_type: ?bool,

    pub const json_field_names = .{
        .endpoint_uri = "EndpointUri",
        .error_retry_duration = "ErrorRetryDuration",
        .full_load_error_percentage = "FullLoadErrorPercentage",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .use_new_mapping_type = "UseNewMappingType",
    };
};

pub const ListTagsForResourceRequest = struct {
    /// The maximum number of tags returned on each page. The limit maximum is 50.
    /// You cannot specify a number greater than 50. If you specify 0, Config uses
    /// the default.
    limit: ?i32 = null,

    /// The `nextToken` string returned on a previous page that you use to get the
    /// next page of results in a paginated response.
    next_token: ?[]const u8,

    /// The Amazon Resource Name (ARN) that identifies the resource for which to
    /// list the tags. The following resources are supported:
    ///
    /// * `ConfigurationRecorder`
    ///
    /// * `ConfigRule`
    ///
    /// * `OrganizationConfigRule`
    ///
    /// * `ConformancePack`
    ///
    /// * `OrganizationConformancePack`
    ///
    /// * `ConfigurationAggregator`
    ///
    /// * `AggregationAuthorization`
    ///
    /// * `StoredQuery`
    resource_arn: []const u8,

    pub const json_field_names = .{
        .limit = "Limit",
        .next_token = "NextToken",
        .resource_arn = "ResourceArn",
    };
};

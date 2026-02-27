const Tag = @import("tag.zig").Tag;

pub const TagResourceRequest = struct {
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

    /// An array of tag object.
    tags: []const Tag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};

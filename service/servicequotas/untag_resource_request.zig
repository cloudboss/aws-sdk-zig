pub const UntagResourceRequest = struct {
    /// The Amazon Resource Name (ARN) for the applied quota that you want to untag.
    /// You can
    /// get this information by using the Service Quotas console, or by listing the
    /// quotas using the
    /// [list-service-quotas](https://docs.aws.amazon.com/cli/latest/reference/service-quotas/list-service-quotas.html) CLI command or the [ListServiceQuotas](https://docs.aws.amazon.com/servicequotas/2019-06-24/apireference/API_ListServiceQuotas.html) Amazon Web Services API operation.
    resource_arn: []const u8,

    /// The keys of the tags that you want to remove from the resource.
    tag_keys: []const []const u8,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tag_keys = "TagKeys",
    };
};

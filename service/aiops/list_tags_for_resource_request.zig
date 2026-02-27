pub const ListTagsForResourceRequest = struct {
    /// The ARN of the CloudWatch investigations resource that you want to view tags
    /// for. You can use the `ListInvestigationGroups` operation to find the ARNs of
    /// investigation groups.
    ///
    /// The ARN format for an investigation group is
    /// `arn:aws:aiops:*Region*:*account-id*:investigation-group:*investigation-group-id* `.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};

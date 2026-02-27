/// Metadata about tasks where an image was in use.
pub const AwsEcsMetadataDetails = struct {
    /// The details group information for a task in a cluster.
    details_group: []const u8,

    /// The task definition ARN.
    task_definition_arn: []const u8,

    pub const json_field_names = .{
        .details_group = "detailsGroup",
        .task_definition_arn = "taskDefinitionArn",
    };
};

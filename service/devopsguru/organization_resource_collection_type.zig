pub const OrganizationResourceCollectionType = enum {
    aws_cloud_formation,
    aws_service,
    aws_account,
    aws_tags,

    pub const json_field_names = .{
        .aws_cloud_formation = "AWS_CLOUD_FORMATION",
        .aws_service = "AWS_SERVICE",
        .aws_account = "AWS_ACCOUNT",
        .aws_tags = "AWS_TAGS",
    };
};

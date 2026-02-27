pub const UpdateGroupRequest = struct {
    /// The ID for the Amazon Web Services account that the group is in. Currently,
    /// you use the ID for the
    /// Amazon Web Services account that contains your Amazon Quick Sight account.
    aws_account_id: []const u8,

    /// The description for the group that you want to update.
    description: ?[]const u8,

    /// The name of the group that you want to update.
    group_name: []const u8,

    /// The namespace of the group that you want to update.
    namespace: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .description = "Description",
        .group_name = "GroupName",
        .namespace = "Namespace",
    };
};

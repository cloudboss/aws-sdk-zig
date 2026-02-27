/// The request object for this operation.
pub const CreateGroupRequest = struct {
    /// The ID for the Amazon Web Services account that the group is in. Currently,
    /// you use the ID for the
    /// Amazon Web Services account that contains your Amazon Quick Sight account.
    aws_account_id: []const u8,

    /// A description for the group that you want to create.
    description: ?[]const u8,

    /// A name for the group that you want to create.
    group_name: []const u8,

    /// The namespace that you want the group to be a part of.
    namespace: []const u8,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .description = "Description",
        .group_name = "GroupName",
        .namespace = "Namespace",
    };
};

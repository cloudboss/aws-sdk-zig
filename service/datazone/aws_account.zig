/// The account ID of a project.
pub const AwsAccount = union(enum) {
    /// The account ID of a project.
    aws_account_id: ?[]const u8,
    /// The account ID path of a project.
    aws_account_id_path: ?[]const u8,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_id_path = "awsAccountIdPath",
    };
};

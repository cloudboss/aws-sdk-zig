/// The location of a project.
pub const AwsLocation = struct {
    /// The access role of a connection.
    access_role: ?[]const u8 = null,

    /// The account ID of a connection.
    aws_account_id: ?[]const u8 = null,

    /// The Region of a connection.
    aws_region: ?[]const u8 = null,

    /// The IAM connection ID of a connection.
    iam_connection_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_role = "accessRole",
        .aws_account_id = "awsAccountId",
        .aws_region = "awsRegion",
        .iam_connection_id = "iamConnectionId",
    };
};

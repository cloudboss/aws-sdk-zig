/// The account information within an account pool.
pub const AccountInfo = struct {
    /// The account ID.
    aws_account_id: []const u8,

    /// The account name.
    aws_account_name: ?[]const u8,

    /// The regions supported for an account within an account pool.
    supported_regions: []const []const u8,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .aws_account_name = "awsAccountName",
        .supported_regions = "supportedRegions",
    };
};

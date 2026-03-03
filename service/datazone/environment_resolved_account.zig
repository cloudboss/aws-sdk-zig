/// Specifies the account/Region that is to be used during project creation for
/// a particular blueprint.
pub const EnvironmentResolvedAccount = struct {
    /// The ID of the resolved account.
    aws_account_id: []const u8,

    /// The name of the resolved Region.
    region_name: []const u8,

    /// The ID of the account pool.
    source_account_pool_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .region_name = "regionName",
        .source_account_pool_id = "sourceAccountPoolId",
    };
};

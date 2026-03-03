/// Describes a token.
pub const TokenData = struct {
    /// Token expiration time, in ISO8601-UTC format.
    expiration_time: ?[]const u8 = null,

    /// Amazon Resource Name (ARN) of the license.
    license_arn: ?[]const u8 = null,

    /// Amazon Resource Names (ARN) of the roles included in the token.
    role_arns: ?[]const []const u8 = null,

    /// Token status. The possible values are `AVAILABLE` and `DELETED`.
    status: ?[]const u8 = null,

    /// Token ID.
    token_id: ?[]const u8 = null,

    /// Data specified by the caller.
    token_properties: ?[]const []const u8 = null,

    /// Type of token generated. The supported value is `REFRESH_TOKEN`.
    token_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .expiration_time = "ExpirationTime",
        .license_arn = "LicenseArn",
        .role_arns = "RoleArns",
        .status = "Status",
        .token_id = "TokenId",
        .token_properties = "TokenProperties",
        .token_type = "TokenType",
    };
};

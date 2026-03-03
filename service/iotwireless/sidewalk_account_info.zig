/// Information about a Sidewalk account.
pub const SidewalkAccountInfo = struct {
    /// The Sidewalk Amazon ID.
    amazon_id: ?[]const u8 = null,

    /// The Sidewalk application server private key.
    app_server_private_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .amazon_id = "AmazonId",
        .app_server_private_key = "AppServerPrivateKey",
    };
};

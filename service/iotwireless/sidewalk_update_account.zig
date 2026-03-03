/// Sidewalk update.
pub const SidewalkUpdateAccount = struct {
    /// The new Sidewalk application server private key.
    app_server_private_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_server_private_key = "AppServerPrivateKey",
    };
};

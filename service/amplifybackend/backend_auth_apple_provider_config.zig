/// Describes Apple social federation configurations for allowing your app users
/// to sign in using OAuth.
pub const BackendAuthAppleProviderConfig = struct {
    /// Describes the client_id (also called Services ID) that comes from Apple.
    client_id: ?[]const u8,

    /// Describes the key_id that comes from Apple.
    key_id: ?[]const u8,

    /// Describes the private_key that comes from Apple.
    private_key: ?[]const u8,

    /// Describes the team_id that comes from Apple.
    team_id: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .key_id = "KeyId",
        .private_key = "PrivateKey",
        .team_id = "TeamId",
    };
};

/// A short description of a user pool app client.
pub const UserPoolClientDescription = struct {
    /// The app client ID.
    client_id: ?[]const u8,

    /// The app client name.
    client_name: ?[]const u8,

    /// The ID of the user pool that's associated with the app client.
    user_pool_id: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "ClientId",
        .client_name = "ClientName",
        .user_pool_id = "UserPoolId",
    };
};

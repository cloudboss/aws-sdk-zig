const NewDeviceMetadataType = @import("new_device_metadata_type.zig").NewDeviceMetadataType;

/// The object that your application receives after authentication. Contains
/// tokens and
/// information for device authentication.
pub const AuthenticationResultType = struct {
    /// Your user's access token.
    access_token: ?[]const u8,

    /// The expiration period of the authentication result in seconds.
    expires_in: i32 = 0,

    /// Your user's ID token.
    id_token: ?[]const u8,

    /// The new device metadata from an authentication result.
    new_device_metadata: ?NewDeviceMetadataType,

    /// Your user's refresh token.
    refresh_token: ?[]const u8,

    /// The intended use of the token, for example `Bearer`.
    token_type: ?[]const u8,

    pub const json_field_names = .{
        .access_token = "AccessToken",
        .expires_in = "ExpiresIn",
        .id_token = "IdToken",
        .new_device_metadata = "NewDeviceMetadata",
        .refresh_token = "RefreshToken",
        .token_type = "TokenType",
    };
};

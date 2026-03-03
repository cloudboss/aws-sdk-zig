/// Information about a profile outbound request
pub const ProfileOutboundRequest = struct {
    client_token: []const u8,

    expiration_time: ?i64 = null,

    profile_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .expiration_time = "expirationTime",
        .profile_id = "profileId",
    };
};

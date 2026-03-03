/// A successful request identified by the unique client token.
pub const SuccessfulRequest = struct {
    client_token: ?[]const u8 = null,

    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
    };
};

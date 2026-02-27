/// A successful request identified by the unique client token.
pub const SuccessfulRequest = struct {
    client_token: ?[]const u8,

    id: ?[]const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
    };
};

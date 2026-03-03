/// Success details for a profile outbound request
pub const SuccessfulProfileOutboundRequest = struct {
    client_token: ?[]const u8 = null,

    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
    };
};

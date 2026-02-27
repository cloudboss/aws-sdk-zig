/// Success details for a profile outbound request
pub const SuccessfulProfileOutboundRequest = struct {
    client_token: ?[]const u8,

    id: ?[]const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
    };
};

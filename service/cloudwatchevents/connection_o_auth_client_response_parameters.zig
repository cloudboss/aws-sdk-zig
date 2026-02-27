/// Contains the client response parameters for the connection when OAuth is
/// specified as the
/// authorization type.
pub const ConnectionOAuthClientResponseParameters = struct {
    /// The client ID associated with the response to the connection request.
    client_id: ?[]const u8,

    pub const json_field_names = .{
        .client_id = "ClientID",
    };
};

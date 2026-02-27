/// Describes the configuration of a request to exchange an access code for a
/// token.
pub const ExchangeCodeForTokenRequestBody = struct {
    /// The ID of the client to request the token from.
    client_id: ?[]const u8,

    /// The access code to send in the request.
    code: []const u8,

    /// The location of the application that will receive the access code.
    redirect_uri: []const u8,

    pub const json_field_names = .{
        .client_id = "clientId",
        .code = "code",
        .redirect_uri = "redirectUri",
    };
};

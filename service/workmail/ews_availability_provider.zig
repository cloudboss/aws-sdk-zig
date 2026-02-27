/// Describes an EWS based availability provider. This is only used as input to
/// the service.
pub const EwsAvailabilityProvider = struct {
    /// The endpoint of the remote EWS server.
    ews_endpoint: []const u8,

    /// The password used to authenticate the remote EWS server.
    ews_password: []const u8,

    /// The username used to authenticate the remote EWS server.
    ews_username: []const u8,

    pub const json_field_names = .{
        .ews_endpoint = "EwsEndpoint",
        .ews_password = "EwsPassword",
        .ews_username = "EwsUsername",
    };
};

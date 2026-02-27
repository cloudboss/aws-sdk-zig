/// Describes an EWS based availability provider when returned from the service.
/// It does not
/// contain the password of the endpoint.
pub const RedactedEwsAvailabilityProvider = struct {
    /// The endpoint of the remote EWS server.
    ews_endpoint: ?[]const u8,

    /// The username used to authenticate the remote EWS server.
    ews_username: ?[]const u8,

    pub const json_field_names = .{
        .ews_endpoint = "EwsEndpoint",
        .ews_username = "EwsUsername",
    };
};

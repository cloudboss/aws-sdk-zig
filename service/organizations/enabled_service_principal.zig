/// A structure that contains details of a service principal that represents an
/// Amazon Web Services
/// service that is enabled to integrate with Organizations.
pub const EnabledServicePrincipal = struct {
    /// The date that the service principal was enabled for integration with
    /// Organizations.
    date_enabled: ?i64 = null,

    /// The name of the service principal. This is typically in the form of a URL,
    /// such as:
    /// `
    /// *servicename*.amazonaws.com`.
    service_principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .date_enabled = "DateEnabled",
        .service_principal = "ServicePrincipal",
    };
};

const OAuthProperties = @import("o_auth_properties.zig").OAuthProperties;

/// The connector-specific profile properties required when using SAPOData.
pub const SAPODataConnectorProfileProperties = struct {
    /// The location of the SAPOData resource.
    application_host_url: []const u8,

    /// The application path to catalog service.
    application_service_path: []const u8,

    /// The client number for the client creating the connection.
    client_number: []const u8,

    /// If you set this parameter to `true`, Amazon AppFlow bypasses the single
    /// sign-on (SSO) settings in your SAP account when it accesses your SAP OData
    /// instance.
    ///
    /// Whether you need this option depends on the types of credentials that you
    /// applied to your
    /// SAP OData connection profile. If your profile uses basic authentication
    /// credentials, SAP SSO
    /// can prevent Amazon AppFlow from connecting to your account with your
    /// username and
    /// password. In this case, bypassing SSO makes it possible for Amazon AppFlow
    /// to connect
    /// successfully. However, if your profile uses OAuth credentials, this
    /// parameter has no
    /// affect.
    disable_sso: bool = false,

    /// The logon language of SAPOData instance.
    logon_language: ?[]const u8,

    /// The SAPOData OAuth properties required for OAuth type authentication.
    o_auth_properties: ?OAuthProperties,

    /// The port number of the SAPOData instance.
    port_number: i32,

    /// The SAPOData Private Link service name to be used for private data
    /// transfers.
    private_link_service_name: ?[]const u8,

    pub const json_field_names = .{
        .application_host_url = "applicationHostUrl",
        .application_service_path = "applicationServicePath",
        .client_number = "clientNumber",
        .disable_sso = "disableSSO",
        .logon_language = "logonLanguage",
        .o_auth_properties = "oAuthProperties",
        .port_number = "portNumber",
        .private_link_service_name = "privateLinkServiceName",
    };
};

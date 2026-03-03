const SamlStatusEnum = @import("saml_status_enum.zig").SamlStatusEnum;

/// Describes the enablement status, user access URL, and relay state parameter
/// name that
/// are used for configuring federation with an SAML 2.0 identity provider.
pub const SamlProperties = struct {
    /// The relay state parameter name supported by the SAML 2.0 identity provider
    /// (IdP). When the end user is redirected to
    /// the user access URL from the WorkSpaces client application, this relay state
    /// parameter name is appended as a query
    /// parameter to the URL along with the relay state endpoint to return the user
    /// to the client application session.
    ///
    /// To use SAML 2.0 authentication with WorkSpaces, the IdP must support
    /// IdP-initiated deep linking for the relay state
    /// URL. Consult your IdP documentation for more information.
    relay_state_parameter_name: ?[]const u8 = null,

    /// Indicates the status of SAML 2.0 authentication. These statuses include the
    /// following.
    ///
    /// * If the setting is `DISABLED`, end users will be directed to login with
    ///   their directory credentials.
    ///
    /// * If the setting is `ENABLED`, end users will be directed to login via the
    ///   user access URL. Users attempting
    /// to connect to WorkSpaces from a client application that does not support
    /// SAML 2.0 authentication will not be able to
    /// connect.
    ///
    /// * If the setting is `ENABLED_WITH_DIRECTORY_LOGIN_FALLBACK`, end users will
    ///   be directed to login via the user
    /// access URL on supported client applications, but will not prevent clients
    /// that do not support SAML 2.0 authentication
    /// from connecting as if SAML 2.0 authentication was disabled.
    status: ?SamlStatusEnum = null,

    /// The SAML 2.0 identity provider (IdP) user access URL is the URL a user would
    /// navigate to in their web browser in
    /// order to federate from the IdP and directly access the application, without
    /// any SAML 2.0 service provider (SP)
    /// bindings.
    user_access_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .relay_state_parameter_name = "RelayStateParameterName",
        .status = "Status",
        .user_access_url = "UserAccessUrl",
    };
};

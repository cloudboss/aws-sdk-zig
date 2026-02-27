const BasicAuthConfiguration = @import("basic_auth_configuration.zig").BasicAuthConfiguration;
const IdcAuthConfiguration = @import("idc_auth_configuration.zig").IdcAuthConfiguration;
const NoAuthConfiguration = @import("no_auth_configuration.zig").NoAuthConfiguration;
const OAuth2ClientCredentialConfiguration = @import("o_auth_2_client_credential_configuration.zig").OAuth2ClientCredentialConfiguration;

/// Authentication configuration information for an Amazon Q Business plugin.
pub const PluginAuthConfiguration = union(enum) {
    /// Information about the basic authentication credentials used to configure a
    /// plugin.
    basic_auth_configuration: ?BasicAuthConfiguration,
    /// Information about the IAM Identity Center Application used to configure
    /// authentication for a plugin.
    idc_auth_configuration: ?IdcAuthConfiguration,
    /// Information about invoking a custom plugin without any authentication.
    no_auth_configuration: ?NoAuthConfiguration,
    /// Information about the OAuth 2.0 authentication credential/token used to
    /// configure a plugin.
    o_auth_2_client_credential_configuration: ?OAuth2ClientCredentialConfiguration,

    pub const json_field_names = .{
        .basic_auth_configuration = "basicAuthConfiguration",
        .idc_auth_configuration = "idcAuthConfiguration",
        .no_auth_configuration = "noAuthConfiguration",
        .o_auth_2_client_credential_configuration = "oAuth2ClientCredentialConfiguration",
    };
};

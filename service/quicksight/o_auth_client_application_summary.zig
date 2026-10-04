const DataSourceType = @import("data_source_type.zig").DataSourceType;
const VpcConnectionProperties = @import("vpc_connection_properties.zig").VpcConnectionProperties;
const OAuthClientAuthenticationType = @import("o_auth_client_authentication_type.zig").OAuthClientAuthenticationType;

/// A summary of an OAuthClientApplication.
pub const OAuthClientApplicationSummary = struct {
    /// The Amazon Resource Name (ARN) of the OAuthClientApplication.
    arn: ?[]const u8 = null,

    /// The time that the OAuthClientApplication was created.
    created_time: ?i64 = null,

    /// The type of data source that the OAuthClientApplication is used with. Valid
    /// values are `SNOWFLAKE`.
    data_source_type: ?DataSourceType = null,

    identity_provider_vpc_connection_properties: ?VpcConnectionProperties = null,

    /// The time that the OAuthClientApplication was last updated.
    last_updated_time: ?i64 = null,

    /// The display name of the OAuthClientApplication.
    name: ?[]const u8 = null,

    /// The ID of the OAuthClientApplication. This ID is unique per Amazon Web
    /// Services Region for each Amazon Web Services account.
    o_auth_client_application_id: ?[]const u8 = null,

    /// The OAuth client authentication type used by the OAuthClientApplication.
    /// Valid values are `TOKEN`.
    o_auth_client_authentication_type: ?OAuthClientAuthenticationType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .data_source_type = "DataSourceType",
        .identity_provider_vpc_connection_properties = "IdentityProviderVpcConnectionProperties",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .o_auth_client_application_id = "OAuthClientApplicationId",
        .o_auth_client_authentication_type = "OAuthClientAuthenticationType",
    };
};

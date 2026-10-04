const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const OAuthParameters = @import("o_auth_parameters.zig").OAuthParameters;

/// The parameters that are required to connect to a Databricks data source.
pub const DatabricksParameters = struct {
    /// The authentication type that you want to use for your connection. This
    /// parameter accepts OAuth and non-OAuth authentication types.
    authentication_type: ?AuthenticationType = null,

    /// The host name of the Databricks data source.
    host: []const u8,

    /// An object that contains information needed to create a data source
    /// connection between an Quick Sight account and Databricks.
    o_auth_parameters: ?OAuthParameters = null,

    /// The port for the Databricks data source.
    port: i32,

    /// The HTTP path of the Databricks data source.
    sql_endpoint_path: []const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .host = "Host",
        .o_auth_parameters = "OAuthParameters",
        .port = "Port",
        .sql_endpoint_path = "SqlEndpointPath",
    };
};

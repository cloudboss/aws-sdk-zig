const AuthenticationType = @import("authentication_type.zig").AuthenticationType;
const OAuthParameters = @import("o_auth_parameters.zig").OAuthParameters;

/// The parameters for Snowflake.
pub const SnowflakeParameters = struct {
    /// The authentication type that you want to use for your connection. This
    /// parameter accepts OAuth and non-OAuth authentication types.
    authentication_type: ?AuthenticationType = null,

    /// Database.
    database: []const u8,

    /// The database access control role.
    database_access_control_role: ?[]const u8 = null,

    /// Host.
    host: []const u8,

    /// An object that contains information needed to create a data source
    /// connection between an Quick Sight account and Snowflake.
    o_auth_parameters: ?OAuthParameters = null,

    /// Warehouse.
    warehouse: []const u8,

    pub const json_field_names = .{
        .authentication_type = "AuthenticationType",
        .database = "Database",
        .database_access_control_role = "DatabaseAccessControlRole",
        .host = "Host",
        .o_auth_parameters = "OAuthParameters",
        .warehouse = "Warehouse",
    };
};

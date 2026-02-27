const aws = @import("aws");

const AuthenticationConfigurationInput = @import("authentication_configuration_input.zig").AuthenticationConfigurationInput;
const ConnectionType = @import("connection_type.zig").ConnectionType;

/// A structure that is used to specify testing a connection to a service.
pub const TestConnectionInput = struct {
    /// A structure containing the authentication configuration in the
    /// TestConnection request. Required for a connection to Salesforce using OAuth
    /// authentication.
    authentication_configuration: ?AuthenticationConfigurationInput,

    /// The key-value pairs that define parameters for the connection.
    ///
    /// JDBC connections use the following connection properties:
    ///
    /// * Required: All of (`HOST`, `PORT`, `JDBC_ENGINE`) or `JDBC_CONNECTION_URL`.
    ///
    /// * Required: All of (`USERNAME`, `PASSWORD`) or `SECRET_ID`.
    ///
    /// * Optional: `JDBC_ENFORCE_SSL`, `CUSTOM_JDBC_CERT`,
    ///   `CUSTOM_JDBC_CERT_STRING`, `SKIP_CUSTOM_JDBC_CERT_VALIDATION`. These
    ///   parameters are used to configure SSL with JDBC.
    ///
    /// SALESFORCE connections require the `AuthenticationConfiguration` member to
    /// be configured.
    connection_properties: []const aws.map.StringMapEntry,

    /// The type of connection to test. This operation is only available for the
    /// `JDBC` or `SALESFORCE` connection types.
    connection_type: ConnectionType,

    pub const json_field_names = .{
        .authentication_configuration = "AuthenticationConfiguration",
        .connection_properties = "ConnectionProperties",
        .connection_type = "ConnectionType",
    };
};

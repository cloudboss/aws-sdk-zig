const aws = @import("aws");

const AuthenticationConfigurationInput = @import("authentication_configuration_input.zig").AuthenticationConfigurationInput;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const PhysicalConnectionRequirements = @import("physical_connection_requirements.zig").PhysicalConnectionRequirements;
const ComputeEnvironment = @import("compute_environment.zig").ComputeEnvironment;

/// A structure that is used to specify a connection to create or update.
pub const ConnectionInput = struct {
    /// Connection properties specific to the Athena compute environment.
    athena_properties: ?[]const aws.map.StringMapEntry = null,

    /// The authentication properties of the connection.
    authentication_configuration: ?AuthenticationConfigurationInput = null,

    /// These key-value pairs define parameters for the connection.
    connection_properties: []const aws.map.StringMapEntry,

    /// The type of the connection. Currently, these types are supported:
    ///
    /// * `JDBC` - Designates a connection to a database through Java Database
    ///   Connectivity (JDBC).
    ///
    /// `JDBC` Connections use the following ConnectionParameters.
    ///
    /// * Required: All of (`HOST`, `PORT`, `JDBC_ENGINE`) or `JDBC_CONNECTION_URL`.
    ///
    /// * Required: All of (`USERNAME`, `PASSWORD`) or `SECRET_ID`.
    ///
    /// * Optional: `JDBC_ENFORCE_SSL`, `CUSTOM_JDBC_CERT`,
    ///   `CUSTOM_JDBC_CERT_STRING`, `SKIP_CUSTOM_JDBC_CERT_VALIDATION`. These
    ///   parameters are used to configure SSL with JDBC.
    ///
    /// * `KAFKA` - Designates a connection to an Apache Kafka streaming platform.
    ///
    /// `KAFKA` Connections use the following ConnectionParameters.
    ///
    /// * Required: `KAFKA_BOOTSTRAP_SERVERS`.
    ///
    /// * Optional: `KAFKA_SSL_ENABLED`, `KAFKA_CUSTOM_CERT`,
    ///   `KAFKA_SKIP_CUSTOM_CERT_VALIDATION`. These parameters are used to
    ///   configure SSL with `KAFKA`.
    ///
    /// * Optional: `KAFKA_CLIENT_KEYSTORE`, `KAFKA_CLIENT_KEYSTORE_PASSWORD`,
    ///   `KAFKA_CLIENT_KEY_PASSWORD`, `ENCRYPTED_KAFKA_CLIENT_KEYSTORE_PASSWORD`,
    ///   `ENCRYPTED_KAFKA_CLIENT_KEY_PASSWORD`. These parameters are used to
    ///   configure TLS client configuration with SSL in `KAFKA`.
    ///
    /// * Optional: `KAFKA_SASL_MECHANISM`. Can be specified as `SCRAM-SHA-512`,
    ///   `GSSAPI`, or `AWS_MSK_IAM`.
    ///
    /// * Optional: `KAFKA_SASL_SCRAM_USERNAME`, `KAFKA_SASL_SCRAM_PASSWORD`,
    ///   `ENCRYPTED_KAFKA_SASL_SCRAM_PASSWORD`. These parameters are used to
    ///   configure SASL/SCRAM-SHA-512 authentication with `KAFKA`.
    ///
    /// * Optional: `KAFKA_SASL_GSSAPI_KEYTAB`, `KAFKA_SASL_GSSAPI_KRB5_CONF`,
    ///   `KAFKA_SASL_GSSAPI_SERVICE`, `KAFKA_SASL_GSSAPI_PRINCIPAL`. These
    ///   parameters are used to configure SASL/GSSAPI authentication with `KAFKA`.
    ///
    /// * `MONGODB` - Designates a connection to a MongoDB document database.
    ///
    /// `MONGODB` Connections use the following ConnectionParameters.
    ///
    /// * Required: `CONNECTION_URL`.
    ///
    /// * Required: All of (`USERNAME`, `PASSWORD`) or `SECRET_ID`.
    ///
    /// * `VIEW_VALIDATION_REDSHIFT` - Designates a connection used for view
    ///   validation by Amazon Redshift.
    ///
    /// * `VIEW_VALIDATION_ATHENA` - Designates a connection used for view
    ///   validation by Amazon Athena.
    ///
    /// * `NETWORK` - Designates a network connection to a data source within an
    ///   Amazon Virtual Private Cloud environment (Amazon VPC).
    ///
    /// `NETWORK` Connections do not require ConnectionParameters. Instead, provide
    /// a PhysicalConnectionRequirements.
    ///
    /// * `MARKETPLACE` - Uses configuration settings contained in a connector
    ///   purchased from Amazon Web Services Marketplace to read from and write to
    ///   data stores that are not natively supported by Glue.
    ///
    /// `MARKETPLACE` Connections use the following ConnectionParameters.
    ///
    /// * Required: `CONNECTOR_TYPE`, `CONNECTOR_URL`, `CONNECTOR_CLASS_NAME`,
    ///   `CONNECTION_URL`.
    ///
    /// * Required for `JDBC`
    /// `CONNECTOR_TYPE` connections: All of (`USERNAME`, `PASSWORD`) or
    /// `SECRET_ID`.
    ///
    /// * `CUSTOM` - Uses configuration settings contained in a custom connector to
    ///   read from and write to data stores that are not natively supported by
    ///   Glue.
    ///
    /// For more information on the connection parameters needed for a particular
    /// connector, see the documentation for the connector in [Adding an Glue
    /// connection](https://docs.aws.amazon.com/glue/latest/dg/console-connections.html)in the Glue User Guide.
    ///
    /// `SFTP` is not supported.
    ///
    /// For more information about how optional ConnectionProperties are used to
    /// configure features in Glue, consult [Glue connection
    /// properties](https://docs.aws.amazon.com/glue/latest/dg/connection-defining.html).
    ///
    /// For more information about how optional ConnectionProperties are used to
    /// configure features in Glue Studio, consult [Using connectors and
    /// connections](https://docs.aws.amazon.com/glue/latest/ug/connectors-chapter.html).
    connection_type: ConnectionType,

    /// The description of the connection.
    description: ?[]const u8 = null,

    /// A list of criteria that can be used in selecting this connection.
    match_criteria: ?[]const []const u8 = null,

    /// The name of the connection.
    name: []const u8,

    /// The physical connection requirements, such as virtual private cloud (VPC)
    /// and `SecurityGroup`, that are needed to successfully make this connection.
    physical_connection_requirements: ?PhysicalConnectionRequirements = null,

    /// Connection properties specific to the Python compute environment.
    python_properties: ?[]const aws.map.StringMapEntry = null,

    /// Connection properties specific to the Spark compute environment.
    spark_properties: ?[]const aws.map.StringMapEntry = null,

    /// A flag to validate the credentials during create connection. Default is
    /// true.
    validate_credentials: bool = false,

    /// The compute environments that the specified connection properties are
    /// validated against.
    validate_for_compute_environments: ?[]const ComputeEnvironment = null,

    pub const json_field_names = .{
        .athena_properties = "AthenaProperties",
        .authentication_configuration = "AuthenticationConfiguration",
        .connection_properties = "ConnectionProperties",
        .connection_type = "ConnectionType",
        .description = "Description",
        .match_criteria = "MatchCriteria",
        .name = "Name",
        .physical_connection_requirements = "PhysicalConnectionRequirements",
        .python_properties = "PythonProperties",
        .spark_properties = "SparkProperties",
        .validate_credentials = "ValidateCredentials",
        .validate_for_compute_environments = "ValidateForComputeEnvironments",
    };
};

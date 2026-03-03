const aws = @import("aws");

const AuthenticationConfiguration = @import("authentication_configuration.zig").AuthenticationConfiguration;
const ComputeEnvironment = @import("compute_environment.zig").ComputeEnvironment;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const PhysicalConnectionRequirements = @import("physical_connection_requirements.zig").PhysicalConnectionRequirements;
const ConnectionStatus = @import("connection_status.zig").ConnectionStatus;

/// Defines a connection to a data source.
pub const Connection = struct {
    /// Connection properties specific to the Athena compute environment.
    athena_properties: ?[]const aws.map.StringMapEntry = null,

    /// The authentication properties of the connection.
    authentication_configuration: ?AuthenticationConfiguration = null,

    /// A list of compute environments compatible with the connection.
    compatible_compute_environments: ?[]const ComputeEnvironment = null,

    /// These key-value pairs define parameters for the connection when using the
    /// version 1 Connection schema:
    ///
    /// * `HOST` - The host URI: either the
    /// fully qualified domain name (FQDN) or the IPv4 address of
    /// the database host.
    ///
    /// * `PORT` - The port number, between
    /// 1024 and 65535, of the port on which the database host is
    /// listening for database connections.
    ///
    /// * `USER_NAME` - The name under which
    /// to log in to the database. The value string for `USER_NAME` is "`USERNAME`".
    ///
    /// * `PASSWORD` - A password,
    /// if one is used, for the user name.
    ///
    /// * `ENCRYPTED_PASSWORD` - When you enable connection password protection by
    ///   setting `ConnectionPasswordEncryption` in the Data Catalog encryption
    ///   settings, this field stores the encrypted password.
    ///
    /// * `JDBC_DRIVER_JAR_URI` - The Amazon Simple Storage Service (Amazon S3) path
    ///   of the
    /// JAR file that contains the JDBC driver to use.
    ///
    /// * `JDBC_DRIVER_CLASS_NAME` - The class name of the JDBC driver to use.
    ///
    /// * `JDBC_ENGINE` - The name of the JDBC engine to use.
    ///
    /// * `JDBC_ENGINE_VERSION` - The version of the JDBC engine to use.
    ///
    /// * `CONFIG_FILES` - (Reserved for future use.)
    ///
    /// * `INSTANCE_ID` - The instance ID to use.
    ///
    /// * `JDBC_CONNECTION_URL` - The URL for connecting to a JDBC data source.
    ///
    /// * `JDBC_ENFORCE_SSL` - A case-insensitive Boolean string (true, false)
    ///   specifying whether Secure
    /// Sockets Layer (SSL) with hostname matching is enforced for the JDBC
    /// connection on the
    /// client. The default is false.
    ///
    /// * `CUSTOM_JDBC_CERT` - An Amazon S3 location specifying the customer's root
    ///   certificate. Glue uses this root certificate to validate the customer’s
    ///   certificate when connecting to the customer database. Glue only handles
    ///   X.509 certificates. The certificate provided must be DER-encoded and
    ///   supplied in Base64 encoding PEM format.
    ///
    /// * `SKIP_CUSTOM_JDBC_CERT_VALIDATION` - By default, this is `false`. Glue
    ///   validates the Signature algorithm and Subject Public Key Algorithm for the
    ///   customer certificate. The only permitted algorithms for the Signature
    ///   algorithm are SHA256withRSA, SHA384withRSA or SHA512withRSA. For the
    ///   Subject Public Key Algorithm, the key length must be at least 2048. You
    ///   can set the value of this property to `true` to skip Glue’s validation of
    ///   the customer certificate.
    ///
    /// * `CUSTOM_JDBC_CERT_STRING` - A custom JDBC certificate string which is used
    ///   for domain match or distinguished name match to prevent a
    ///   man-in-the-middle attack. In Oracle database, this is used as the
    ///   `SSL_SERVER_CERT_DN`; in Microsoft SQL Server, this is used as the
    ///   `hostNameInCertificate`.
    ///
    /// * `CONNECTION_URL` - The URL for connecting to a general (non-JDBC) data
    ///   source.
    ///
    /// * `SECRET_ID` - The secret ID used for the secret manager of credentials.
    ///
    /// * `CONNECTOR_URL` - The connector URL for a MARKETPLACE or CUSTOM
    ///   connection.
    ///
    /// * `CONNECTOR_TYPE` - The connector type for a MARKETPLACE or CUSTOM
    ///   connection.
    ///
    /// * `CONNECTOR_CLASS_NAME` - The connector class name for a MARKETPLACE or
    ///   CUSTOM connection.
    ///
    /// * `KAFKA_BOOTSTRAP_SERVERS` - A comma-separated list of host and port pairs
    ///   that are the addresses of the Apache Kafka brokers in a Kafka cluster to
    ///   which a Kafka client will connect to and bootstrap itself.
    ///
    /// * `KAFKA_SSL_ENABLED` - Whether to enable or disable SSL on an Apache Kafka
    ///   connection. Default value is "true".
    ///
    /// * `KAFKA_CUSTOM_CERT` - The Amazon S3 URL for the private CA cert file (.pem
    ///   format). The default is an empty string.
    ///
    /// * `KAFKA_SKIP_CUSTOM_CERT_VALIDATION` - Whether to skip the validation of
    ///   the CA cert file or not. Glue validates for three algorithms:
    ///   SHA256withRSA, SHA384withRSA and SHA512withRSA. Default value is "false".
    ///
    /// * `KAFKA_CLIENT_KEYSTORE` - The Amazon S3 location of the client keystore
    ///   file for Kafka client side authentication (Optional).
    ///
    /// * `KAFKA_CLIENT_KEYSTORE_PASSWORD` - The password to access the provided
    ///   keystore (Optional).
    ///
    /// * `KAFKA_CLIENT_KEY_PASSWORD` - A keystore can consist of multiple keys, so
    ///   this is the password to access the client key to be used with the Kafka
    ///   server side key (Optional).
    ///
    /// * `ENCRYPTED_KAFKA_CLIENT_KEYSTORE_PASSWORD` - The encrypted version of the
    ///   Kafka client keystore password (if the user has the Glue encrypt passwords
    ///   setting selected).
    ///
    /// * `ENCRYPTED_KAFKA_CLIENT_KEY_PASSWORD` - The encrypted version of the Kafka
    ///   client key password (if the user has the Glue encrypt passwords setting
    ///   selected).
    ///
    /// * `KAFKA_SASL_MECHANISM` - `"SCRAM-SHA-512"`, `"GSSAPI"`, `"AWS_MSK_IAM"`,
    ///   or `"PLAIN"`. These are the supported [SASL
    ///   Mechanisms](https://www.iana.org/assignments/sasl-mechanisms/sasl-mechanisms.xhtml).
    ///
    /// * `KAFKA_SASL_PLAIN_USERNAME` - A plaintext username used to authenticate
    ///   with the "PLAIN" mechanism.
    ///
    /// * `KAFKA_SASL_PLAIN_PASSWORD` - A plaintext password used to authenticate
    ///   with the "PLAIN" mechanism.
    ///
    /// * `ENCRYPTED_KAFKA_SASL_PLAIN_PASSWORD` - The encrypted version of the Kafka
    ///   SASL PLAIN password (if the user has the Glue encrypt passwords setting
    ///   selected).
    ///
    /// * `KAFKA_SASL_SCRAM_USERNAME` - A plaintext username used to authenticate
    ///   with the "SCRAM-SHA-512" mechanism.
    ///
    /// * `KAFKA_SASL_SCRAM_PASSWORD` - A plaintext password used to authenticate
    ///   with the "SCRAM-SHA-512" mechanism.
    ///
    /// * `ENCRYPTED_KAFKA_SASL_SCRAM_PASSWORD` - The encrypted version of the Kafka
    ///   SASL SCRAM password (if the user has the Glue encrypt passwords setting
    ///   selected).
    ///
    /// * `KAFKA_SASL_SCRAM_SECRETS_ARN` - The Amazon Resource Name of a secret in
    ///   Amazon Web Services Secrets Manager.
    ///
    /// * `KAFKA_SASL_GSSAPI_KEYTAB` - The S3 location of a Kerberos `keytab` file.
    ///   A keytab stores long-term keys for one or more principals. For more
    ///   information, see [MIT Kerberos Documentation:
    ///   Keytab](https://web.mit.edu/kerberos/krb5-latest/doc/basic/keytab_def.html).
    ///
    /// * `KAFKA_SASL_GSSAPI_KRB5_CONF` - The S3 location of a Kerberos `krb5.conf`
    ///   file. A krb5.conf stores Kerberos configuration information, such as the
    ///   location of the KDC server. For more information, see [MIT Kerberos
    ///   Documentation:
    ///   krb5.conf](https://web.mit.edu/kerberos/krb5-1.12/doc/admin/conf_files/krb5_conf.html).
    ///
    /// * `KAFKA_SASL_GSSAPI_SERVICE` - The Kerberos service name, as set with
    ///   `sasl.kerberos.service.name` in your [Kafka
    ///   Configuration](https://kafka.apache.org/documentation/#brokerconfigs_sasl.kerberos.service.name).
    ///
    /// * `KAFKA_SASL_GSSAPI_PRINCIPAL` - The name of the Kerberos princial used by
    ///   Glue. For more information, see [Kafka Documentation: Configuring Kafka
    ///   Brokers](https://kafka.apache.org/documentation/#security_sasl_kerberos_clientconfig).
    ///
    /// * `ROLE_ARN` - The role to be used for running queries.
    ///
    /// * `REGION` - The Amazon Web Services Region where queries will be run.
    ///
    /// * `WORKGROUP_NAME` - The name of an Amazon Redshift serverless workgroup or
    ///   Amazon Athena workgroup in which queries will run.
    ///
    /// * `CLUSTER_IDENTIFIER` - The cluster identifier of an Amazon Redshift
    ///   cluster in which queries will run.
    ///
    /// * `DATABASE` - The Amazon Redshift database that you are connecting to.
    connection_properties: ?[]const aws.map.StringMapEntry = null,

    /// The version of the connection schema for this connection. Version 2 supports
    /// properties for specific compute environments.
    connection_schema_version: ?i32 = null,

    /// The type of the connection. Currently, SFTP is not supported.
    connection_type: ?ConnectionType = null,

    /// The timestamp of the time that this connection definition was created.
    creation_time: ?i64 = null,

    /// The description of the connection.
    description: ?[]const u8 = null,

    /// A timestamp of the time this connection was last validated.
    last_connection_validation_time: ?i64 = null,

    /// The user, group, or role that last updated this connection definition.
    last_updated_by: ?[]const u8 = null,

    /// The timestamp of the last time the connection definition was updated.
    last_updated_time: ?i64 = null,

    /// A list of criteria that can be used in selecting this connection.
    match_criteria: ?[]const []const u8 = null,

    /// The name of the connection definition.
    name: ?[]const u8 = null,

    /// The physical connection requirements, such as virtual private cloud (VPC)
    /// and `SecurityGroup`, that are needed to make this connection successfully.
    physical_connection_requirements: ?PhysicalConnectionRequirements = null,

    /// Connection properties specific to the Python compute environment.
    python_properties: ?[]const aws.map.StringMapEntry = null,

    /// Connection properties specific to the Spark compute environment.
    spark_properties: ?[]const aws.map.StringMapEntry = null,

    /// The status of the connection. Can be one of: `READY`, `IN_PROGRESS`, or
    /// `FAILED`.
    status: ?ConnectionStatus = null,

    /// The reason for the connection status.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .athena_properties = "AthenaProperties",
        .authentication_configuration = "AuthenticationConfiguration",
        .compatible_compute_environments = "CompatibleComputeEnvironments",
        .connection_properties = "ConnectionProperties",
        .connection_schema_version = "ConnectionSchemaVersion",
        .connection_type = "ConnectionType",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_connection_validation_time = "LastConnectionValidationTime",
        .last_updated_by = "LastUpdatedBy",
        .last_updated_time = "LastUpdatedTime",
        .match_criteria = "MatchCriteria",
        .name = "Name",
        .physical_connection_requirements = "PhysicalConnectionRequirements",
        .python_properties = "PythonProperties",
        .spark_properties = "SparkProperties",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

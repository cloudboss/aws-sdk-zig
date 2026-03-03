const MessageFormatValue = @import("message_format_value.zig").MessageFormatValue;
const KafkaSaslMechanism = @import("kafka_sasl_mechanism.zig").KafkaSaslMechanism;
const KafkaSecurityProtocol = @import("kafka_security_protocol.zig").KafkaSecurityProtocol;
const KafkaSslEndpointIdentificationAlgorithm = @import("kafka_ssl_endpoint_identification_algorithm.zig").KafkaSslEndpointIdentificationAlgorithm;

/// Provides information that describes an Apache Kafka endpoint. This
/// information includes
/// the output format of records applied to the endpoint and details of
/// transaction and control
/// table data information.
pub const KafkaSettings = struct {
    /// A comma-separated list of one or more broker locations in your Kafka cluster
    /// that host
    /// your Kafka instance. Specify each broker location in the form
    /// `
    /// *broker-hostname-or-ip*:*port*
    /// `.
    /// For example, `"ec2-12-345-678-901.compute-1.amazonaws.com:2345"`. For more
    /// information and examples of specifying a list of broker locations, see
    /// [Using Apache
    /// Kafka as a target for Database Migration
    /// Service](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kafka.html) in the *Database Migration Service User
    /// Guide*.
    broker: ?[]const u8 = null,

    /// Shows detailed control information for table definition, column definition,
    /// and table
    /// and column changes in the Kafka message output. The default is `false`.
    include_control_details: ?bool = null,

    /// Include NULL and empty columns for records migrated to the endpoint. The
    /// default is
    /// `false`.
    include_null_and_empty: ?bool = null,

    /// Shows the partition value within the Kafka message output unless the
    /// partition type is
    /// `schema-table-type`. The default is `false`.
    include_partition_value: ?bool = null,

    /// Includes any data definition language (DDL) operations that change the table
    /// in the
    /// control data, such as `rename-table`, `drop-table`,
    /// `add-column`, `drop-column`, and `rename-column`. The
    /// default is `false`.
    include_table_alter_operations: ?bool = null,

    /// Provides detailed transaction information from the source database. This
    /// information
    /// includes a commit timestamp, a log position, and values for
    /// `transaction_id`,
    /// previous `transaction_id`, and `transaction_record_id` (the record
    /// offset within a transaction). The default is `false`.
    include_transaction_details: ?bool = null,

    /// The output format for the records created on the endpoint. The message
    /// format is
    /// `JSON` (default) or `JSON_UNFORMATTED` (a single line with no
    /// tab).
    message_format: ?MessageFormatValue = null,

    /// The maximum size in bytes for records created on the endpoint The default is
    /// 1,000,000.
    message_max_bytes: ?i32 = null,

    /// Set this optional parameter to `true` to avoid adding a '0x' prefix
    /// to raw data in hexadecimal format. For example, by default, DMS adds a '0x'
    /// prefix to the LOB column type in hexadecimal format moving from an Oracle
    /// source to a Kafka
    /// target. Use the `NoHexPrefix` endpoint setting to enable migration of RAW
    /// data
    /// type columns without adding the '0x' prefix.
    no_hex_prefix: ?bool = null,

    /// Prefixes schema and table names to partition values, when the partition type
    /// is
    /// `primary-key-type`. Doing this increases data distribution among Kafka
    /// partitions. For example, suppose that a SysBench schema has thousands of
    /// tables and each
    /// table has only limited range for a primary key. In this case, the same
    /// primary key is sent
    /// from thousands of tables to the same partition, which causes throttling. The
    /// default is
    /// `false`.
    partition_include_schema_table: ?bool = null,

    /// For SASL/SSL authentication, DMS supports the `SCRAM-SHA-512` mechanism by
    /// default. DMS versions 3.5.0 and later also support the `PLAIN` mechanism. To
    /// use the `PLAIN` mechanism, set this parameter to `PLAIN.`
    sasl_mechanism: ?KafkaSaslMechanism = null,

    /// The secure password you created when you first set up your MSK cluster to
    /// validate a
    /// client identity and make an encrypted connection between server and client
    /// using SASL-SSL
    /// authentication.
    sasl_password: ?[]const u8 = null,

    /// The secure user name you created when you first set up your MSK cluster to
    /// validate a
    /// client identity and make an encrypted connection between server and client
    /// using SASL-SSL
    /// authentication.
    sasl_username: ?[]const u8 = null,

    /// Set secure connection to a Kafka target endpoint using Transport Layer
    /// Security (TLS).
    /// Options include `ssl-encryption`, `ssl-authentication`, and
    /// `sasl-ssl`. `sasl-ssl` requires `SaslUsername` and
    /// `SaslPassword`.
    security_protocol: ?KafkaSecurityProtocol = null,

    /// The Amazon Resource Name (ARN) for the private certificate authority (CA)
    /// cert that
    /// DMS uses to securely connect to your Kafka target endpoint.
    ssl_ca_certificate_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the client certificate used to securely
    /// connect to a
    /// Kafka target endpoint.
    ssl_client_certificate_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the client private key used to securely
    /// connect to a
    /// Kafka target endpoint.
    ssl_client_key_arn: ?[]const u8 = null,

    /// The password for the client private key used to securely connect to a Kafka
    /// target
    /// endpoint.
    ssl_client_key_password: ?[]const u8 = null,

    /// Sets hostname verification for the certificate. This setting is supported in
    /// DMS
    /// version 3.5.1 and later.
    ssl_endpoint_identification_algorithm: ?KafkaSslEndpointIdentificationAlgorithm = null,

    /// The topic to which you migrate the data. If you don't specify a topic, DMS
    /// specifies `"kafka-default-topic"` as the migration topic.
    topic: ?[]const u8 = null,

    /// Specifies using the large integer value with Kafka.
    use_large_integer_value: ?bool = null,

    pub const json_field_names = .{
        .broker = "Broker",
        .include_control_details = "IncludeControlDetails",
        .include_null_and_empty = "IncludeNullAndEmpty",
        .include_partition_value = "IncludePartitionValue",
        .include_table_alter_operations = "IncludeTableAlterOperations",
        .include_transaction_details = "IncludeTransactionDetails",
        .message_format = "MessageFormat",
        .message_max_bytes = "MessageMaxBytes",
        .no_hex_prefix = "NoHexPrefix",
        .partition_include_schema_table = "PartitionIncludeSchemaTable",
        .sasl_mechanism = "SaslMechanism",
        .sasl_password = "SaslPassword",
        .sasl_username = "SaslUsername",
        .security_protocol = "SecurityProtocol",
        .ssl_ca_certificate_arn = "SslCaCertificateArn",
        .ssl_client_certificate_arn = "SslClientCertificateArn",
        .ssl_client_key_arn = "SslClientKeyArn",
        .ssl_client_key_password = "SslClientKeyPassword",
        .ssl_endpoint_identification_algorithm = "SslEndpointIdentificationAlgorithm",
        .topic = "Topic",
        .use_large_integer_value = "UseLargeIntegerValue",
    };
};

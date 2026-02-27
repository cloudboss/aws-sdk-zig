const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DmsTransferSettings = @import("dms_transfer_settings.zig").DmsTransferSettings;
const DocDbSettings = @import("doc_db_settings.zig").DocDbSettings;
const DynamoDbSettings = @import("dynamo_db_settings.zig").DynamoDbSettings;
const ElasticsearchSettings = @import("elasticsearch_settings.zig").ElasticsearchSettings;
const ReplicationEndpointTypeValue = @import("replication_endpoint_type_value.zig").ReplicationEndpointTypeValue;
const GcpMySQLSettings = @import("gcp_my_sql_settings.zig").GcpMySQLSettings;
const IBMDb2Settings = @import("ibm_db_2_settings.zig").IBMDb2Settings;
const KafkaSettings = @import("kafka_settings.zig").KafkaSettings;
const KinesisSettings = @import("kinesis_settings.zig").KinesisSettings;
const MicrosoftSQLServerSettings = @import("microsoft_sql_server_settings.zig").MicrosoftSQLServerSettings;
const MongoDbSettings = @import("mongo_db_settings.zig").MongoDbSettings;
const MySQLSettings = @import("my_sql_settings.zig").MySQLSettings;
const NeptuneSettings = @import("neptune_settings.zig").NeptuneSettings;
const OracleSettings = @import("oracle_settings.zig").OracleSettings;
const PostgreSQLSettings = @import("postgre_sql_settings.zig").PostgreSQLSettings;
const RedisSettings = @import("redis_settings.zig").RedisSettings;
const RedshiftSettings = @import("redshift_settings.zig").RedshiftSettings;
const S3Settings = @import("s3_settings.zig").S3Settings;
const DmsSslModeValue = @import("dms_ssl_mode_value.zig").DmsSslModeValue;
const SybaseSettings = @import("sybase_settings.zig").SybaseSettings;
const Tag = @import("tag.zig").Tag;
const TimestreamSettings = @import("timestream_settings.zig").TimestreamSettings;
const Endpoint = @import("endpoint.zig").Endpoint;

pub const CreateEndpointInput = struct {
    /// The Amazon Resource Name (ARN) for the certificate.
    certificate_arn: ?[]const u8 = null,

    /// The name of the endpoint database. For a MySQL source or target endpoint, do
    /// not specify
    /// DatabaseName. To migrate to a specific database, use this setting and
    /// `targetDbType`.
    database_name: ?[]const u8 = null,

    /// The settings in JSON format for the DMS transfer type of source endpoint.
    ///
    /// Possible settings include the following:
    ///
    /// * `ServiceAccessRoleArn` - The Amazon Resource Name (ARN) used by the
    /// service access IAM role. The role must allow the `iam:PassRole`
    /// action.
    ///
    /// * `BucketName` - The name of the S3 bucket to use.
    ///
    /// Shorthand syntax for these settings is as follows:
    /// `ServiceAccessRoleArn=string,BucketName=string`
    ///
    /// JSON syntax for these settings is as follows: `{ "ServiceAccessRoleArn":
    /// "string",
    /// "BucketName": "string", } `
    dms_transfer_settings: ?DmsTransferSettings = null,

    doc_db_settings: ?DocDbSettings = null,

    /// Settings in JSON format for the target Amazon DynamoDB endpoint. For
    /// information about
    /// other available settings, see [Using Object Mapping to Migrate Data to
    /// DynamoDB](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.DynamoDB.html#CHAP_Target.DynamoDB.ObjectMapping) in the *Database Migration Service
    /// User Guide.*
    dynamo_db_settings: ?DynamoDbSettings = null,

    /// Settings in JSON format for the target OpenSearch endpoint. For more
    /// information about the available settings, see [Extra Connection Attributes
    /// When Using OpenSearch as a Target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Elasticsearch.html#CHAP_Target.Elasticsearch.Configuration) in the *Database Migration Service User Guide*.
    elasticsearch_settings: ?ElasticsearchSettings = null,

    /// The database endpoint identifier. Identifiers must begin with a letter and
    /// must contain
    /// only ASCII letters, digits, and hyphens. They can't end with a hyphen, or
    /// contain two
    /// consecutive hyphens.
    endpoint_identifier: []const u8,

    /// The type of endpoint. Valid values are `source` and
    /// `target`.
    endpoint_type: ReplicationEndpointTypeValue,

    /// The type of engine for the endpoint. Valid values, depending on the
    /// `EndpointType` value, include `"mysql"`, `"oracle"`,
    /// `"postgres"`, `"mariadb"`, `"aurora"`,
    /// `"aurora-postgresql"`, `"opensearch"`, `"redshift"`,
    /// `"s3"`, `"db2"`, `"db2-zos"`, `"azuredb"`,
    /// `"sybase"`, `"dynamodb"`, `"mongodb"`,
    /// `"kinesis"`, `"kafka"`, `"elasticsearch"`,
    /// `"docdb"`, `"sqlserver"`, `"neptune"`,
    /// `"babelfish"`, `redshift-serverless`,
    /// `aurora-serverless`, `aurora-postgresql-serverless`,
    /// `gcp-mysql`, `azure-sql-managed-instance`, `redis`,
    /// `dms-transfer`.
    engine_name: []const u8,

    /// The external table definition.
    external_table_definition: ?[]const u8 = null,

    /// Additional attributes associated with the connection. Each attribute is
    /// specified as a
    /// name-value pair associated by an equal sign (=). Multiple attributes are
    /// separated by a
    /// semicolon (;) with no additional white space. For information on the
    /// attributes available
    /// for connecting your source or target endpoint, see [Working with DMS
    /// Endpoints](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Endpoints.html) in
    /// the *Database Migration Service User Guide.*
    extra_connection_attributes: ?[]const u8 = null,

    /// Settings in JSON format for the source GCP MySQL endpoint.
    gcp_my_sql_settings: ?GcpMySQLSettings = null,

    /// Settings in JSON format for the source IBM Db2 LUW endpoint. For information
    /// about other
    /// available settings, see [Extra
    /// connection attributes when using Db2 LUW as a source for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.DB2.html#CHAP_Source.DB2.ConnectionAttrib) in the
    /// *Database Migration Service User Guide.*
    ibm_db_2_settings: ?IBMDb2Settings = null,

    /// Settings in JSON format for the target Apache Kafka endpoint. For more
    /// information about
    /// the available settings, see [Using
    /// object mapping to migrate data to a Kafka
    /// topic](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kafka.html#CHAP_Target.Kafka.ObjectMapping) in the *Database Migration Service User
    /// Guide.*
    kafka_settings: ?KafkaSettings = null,

    /// Settings in JSON format for the target endpoint for Amazon Kinesis Data
    /// Streams. For
    /// more information about the available settings, see [Using object mapping to
    /// migrate data to a Kinesis data
    /// stream](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Kinesis.html#CHAP_Target.Kinesis.ObjectMapping) in the
    /// *Database Migration Service User Guide.*
    kinesis_settings: ?KinesisSettings = null,

    /// An KMS key identifier that is used to encrypt the connection parameters for
    /// the
    /// endpoint.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

    /// Settings in JSON format for the source and target Microsoft SQL Server
    /// endpoint. For
    /// information about other available settings, see [Extra connection attributes
    /// when using SQL Server as a source for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.SQLServer.html#CHAP_Source.SQLServer.ConnectionAttrib) and
    /// [ Extra connection attributes when using SQL Server as a target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.SQLServer.html#CHAP_Target.SQLServer.ConnectionAttrib) in the
    /// *Database Migration Service User Guide.*
    microsoft_sql_server_settings: ?MicrosoftSQLServerSettings = null,

    /// Settings in JSON format for the source MongoDB endpoint. For more
    /// information about the
    /// available settings, see [Endpoint configuration settings when using MongoDB
    /// as a source for Database Migration
    /// Service](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.MongoDB.html#CHAP_Source.MongoDB.Configuration) in
    /// the *Database Migration Service User Guide.*
    mongo_db_settings: ?MongoDbSettings = null,

    /// Settings in JSON format for the source and target MySQL endpoint. For
    /// information about
    /// other available settings, see [Extra connection attributes when using MySQL
    /// as a source for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.MySQL.html#CHAP_Source.MySQL.ConnectionAttrib) and [Extra connection attributes when using a MySQL-compatible database as a target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.MySQL.html#CHAP_Target.MySQL.ConnectionAttrib) in the *Database Migration Service User Guide.*
    my_sql_settings: ?MySQLSettings = null,

    /// Settings in JSON format for the target Amazon Neptune endpoint. For more
    /// information
    /// about the available settings, see [Specifying graph-mapping rules using
    /// Gremlin and R2RML for Amazon
    /// Neptune as a
    /// target](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Neptune.html#CHAP_Target.Neptune.EndpointSettings) in the *Database Migration Service User Guide.*
    neptune_settings: ?NeptuneSettings = null,

    /// Settings in JSON format for the source and target Oracle endpoint. For
    /// information about
    /// other available settings, see [Extra connection attributes when using Oracle
    /// as a source for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.Oracle.html#CHAP_Source.Oracle.ConnectionAttrib) and [
    /// Extra connection attributes when using Oracle as a target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.Oracle.html#CHAP_Target.Oracle.ConnectionAttrib) in the
    /// *Database Migration Service User Guide.*
    oracle_settings: ?OracleSettings = null,

    /// The password to be used to log in to the endpoint database.
    password: ?[]const u8 = null,

    /// The port used by the endpoint database.
    port: ?i32 = null,

    /// Settings in JSON format for the source and target PostgreSQL endpoint. For
    /// information
    /// about other available settings, see [Extra connection attributes when using
    /// PostgreSQL as a source for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.PostgreSQL.html#CHAP_Source.PostgreSQL.ConnectionAttrib) and
    /// [ Extra connection attributes when using PostgreSQL as a target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.PostgreSQL.html#CHAP_Target.PostgreSQL.ConnectionAttrib) in the
    /// *Database Migration Service User Guide.*
    postgre_sql_settings: ?PostgreSQLSettings = null,

    /// Settings in JSON format for the target Redis endpoint.
    redis_settings: ?RedisSettings = null,

    redshift_settings: ?RedshiftSettings = null,

    /// A friendly name for the resource identifier at the end of the `EndpointArn`
    /// response parameter that is returned in the created `Endpoint` object. The
    /// value
    /// for this parameter can have up to 31 characters. It can contain only ASCII
    /// letters, digits,
    /// and hyphen ('-'). Also, it can't end with a hyphen or contain two
    /// consecutive hyphens,
    /// and can only begin with a letter, such as `Example-App-ARN1`. For example,
    /// this
    /// value might result in the `EndpointArn` value
    /// `arn:aws:dms:eu-west-1:012345678901:rep:Example-App-ARN1`. If you don't
    /// specify a `ResourceIdentifier` value, DMS generates a default identifier
    /// value
    /// for the end of `EndpointArn`.
    resource_identifier: ?[]const u8 = null,

    /// Settings in JSON format for the target Amazon S3 endpoint. For more
    /// information about
    /// the available settings, see [Extra
    /// Connection Attributes When Using Amazon S3 as a Target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.S3.html#CHAP_Target.S3.Configuring) in the
    /// *Database Migration Service User Guide.*
    s3_settings: ?S3Settings = null,

    /// The name of the server where the endpoint database resides.
    server_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the service access role that you want to
    /// use to
    /// create the endpoint. The role must allow the `iam:PassRole` action.
    service_access_role_arn: ?[]const u8 = null,

    /// The Secure Sockets Layer (SSL) mode to use for the SSL connection. The
    /// default is
    /// `none`
    ssl_mode: ?DmsSslModeValue = null,

    /// Settings in JSON format for the source and target SAP ASE endpoint. For
    /// information
    /// about other available settings, see [Extra
    /// connection attributes when using SAP ASE as a source for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Source.SAP.html#CHAP_Source.SAP.ConnectionAttrib) and [Extra
    /// connection attributes when using SAP ASE as a target for
    /// DMS](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Target.SAP.html#CHAP_Target.SAP.ConnectionAttrib) in the
    /// *Database Migration Service User Guide.*
    sybase_settings: ?SybaseSettings = null,

    /// One or more tags to be assigned to the endpoint.
    tags: ?[]const Tag = null,

    /// Settings in JSON format for the target Amazon Timestream endpoint.
    timestream_settings: ?TimestreamSettings = null,

    /// The user name to be used to log in to the endpoint database.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .database_name = "DatabaseName",
        .dms_transfer_settings = "DmsTransferSettings",
        .doc_db_settings = "DocDbSettings",
        .dynamo_db_settings = "DynamoDbSettings",
        .elasticsearch_settings = "ElasticsearchSettings",
        .endpoint_identifier = "EndpointIdentifier",
        .endpoint_type = "EndpointType",
        .engine_name = "EngineName",
        .external_table_definition = "ExternalTableDefinition",
        .extra_connection_attributes = "ExtraConnectionAttributes",
        .gcp_my_sql_settings = "GcpMySQLSettings",
        .ibm_db_2_settings = "IBMDb2Settings",
        .kafka_settings = "KafkaSettings",
        .kinesis_settings = "KinesisSettings",
        .kms_key_id = "KmsKeyId",
        .microsoft_sql_server_settings = "MicrosoftSQLServerSettings",
        .mongo_db_settings = "MongoDbSettings",
        .my_sql_settings = "MySQLSettings",
        .neptune_settings = "NeptuneSettings",
        .oracle_settings = "OracleSettings",
        .password = "Password",
        .port = "Port",
        .postgre_sql_settings = "PostgreSQLSettings",
        .redis_settings = "RedisSettings",
        .redshift_settings = "RedshiftSettings",
        .resource_identifier = "ResourceIdentifier",
        .s3_settings = "S3Settings",
        .server_name = "ServerName",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .ssl_mode = "SslMode",
        .sybase_settings = "SybaseSettings",
        .tags = "Tags",
        .timestream_settings = "TimestreamSettings",
        .username = "Username",
    };
};

pub const CreateEndpointOutput = struct {
    /// The endpoint that was created.
    endpoint: ?Endpoint = null,

    pub const json_field_names = .{
        .endpoint = "Endpoint",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEndpointInput, options: Options) !CreateEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "databasemigrationservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("databasemigrationservice", "Database Migration Service", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonDMSv20160101.CreateEndpoint");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateEndpointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEndpointOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CollectorNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .collector_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FailedDependencyFault")) {
        return .{ .arena = arena, .kind = .{ .failed_dependency_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientResourceCapacityFault")) {
        return .{ .arena = arena, .kind = .{ .insufficient_resource_capacity_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidCertificateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_certificate_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidOperationFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceStateFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnet")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSAccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .kms_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSDisabledFault")) {
        return .{ .arena = arena, .kind = .{ .kms_disabled_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSFault")) {
        return .{ .arena = arena, .kind = .{ .kms_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSInvalidStateFault")) {
        return .{ .arena = arena, .kind = .{ .kms_invalid_state_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSKeyNotAccessibleFault")) {
        return .{ .arena = arena, .kind = .{ .kms_key_not_accessible_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .kms_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSThrottlingFault")) {
        return .{ .arena = arena, .kind = .{ .kms_throttling_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationSubnetGroupDoesNotCoverEnoughAZs")) {
        return .{ .arena = arena, .kind = .{ .replication_subnet_group_does_not_cover_enough_a_zs = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsFault")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .resource_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3AccessDeniedFault")) {
        return .{ .arena = arena, .kind = .{ .s3_access_denied_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3ResourceNotFoundFault")) {
        return .{ .arena = arena, .kind = .{ .s3_resource_not_found_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSInvalidTopicFault")) {
        return .{ .arena = arena, .kind = .{ .sns_invalid_topic_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SNSNoAuthorizationFault")) {
        return .{ .arena = arena, .kind = .{ .sns_no_authorization_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StorageQuotaExceededFault")) {
        return .{ .arena = arena, .kind = .{ .storage_quota_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetAlreadyInUse")) {
        return .{ .arena = arena, .kind = .{ .subnet_already_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UpgradeDependencyFailureFault")) {
        return .{ .arena = arena, .kind = .{ .upgrade_dependency_failure_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

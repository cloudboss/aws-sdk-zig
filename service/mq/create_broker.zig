const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AuthenticationStrategy = @import("authentication_strategy.zig").AuthenticationStrategy;
const ConfigurationId = @import("configuration_id.zig").ConfigurationId;
const DataReplicationMode = @import("data_replication_mode.zig").DataReplicationMode;
const DeploymentMode = @import("deployment_mode.zig").DeploymentMode;
const EncryptionOptions = @import("encryption_options.zig").EncryptionOptions;
const EngineType = @import("engine_type.zig").EngineType;
const LdapServerMetadataInput = @import("ldap_server_metadata_input.zig").LdapServerMetadataInput;
const Logs = @import("logs.zig").Logs;
const WeeklyStartTime = @import("weekly_start_time.zig").WeeklyStartTime;
const BrokerStorageType = @import("broker_storage_type.zig").BrokerStorageType;
const User = @import("user.zig").User;

pub const CreateBrokerInput = struct {
    /// Optional. The authentication strategy used to secure the broker. The default
    /// is SIMPLE.
    authentication_strategy: ?AuthenticationStrategy = null,

    /// Enables automatic upgrades to new patch versions for brokers as new versions
    /// are released and supported by Amazon MQ. Automatic upgrades occur during the
    /// scheduled maintenance window or after a manual broker reboot. Set to true by
    /// default, if no value is specified.
    ///
    /// Must be set to true for ActiveMQ brokers version 5.18 and above and for
    /// RabbitMQ brokers version 3.13 and above.
    auto_minor_version_upgrade: ?bool = null,

    /// Required. The broker's name. This value must be unique in your Amazon Web
    /// Services account, 1-50 characters long, must contain only letters, numbers,
    /// dashes, and underscores, and must not contain white spaces, brackets,
    /// wildcard characters, or special characters.
    ///
    /// Do not add personally identifiable information (PII) or other confidential
    /// or sensitive information in broker names. Broker names are accessible to
    /// other Amazon Web Services services, including CloudWatch Logs. Broker names
    /// are not intended to be used for private or sensitive data.
    broker_name: []const u8,

    /// A list of information about the configuration.
    configuration: ?ConfigurationId = null,

    /// The unique ID that the requester receives for the created broker. Amazon MQ
    /// passes your ID with the API action.
    ///
    /// We recommend using a Universally Unique Identifier (UUID) for the
    /// creatorRequestId. You may omit the creatorRequestId if your application
    /// doesn't require idempotency.
    creator_request_id: ?[]const u8 = null,

    /// Defines whether this broker is a part of a data replication pair.
    data_replication_mode: ?DataReplicationMode = null,

    /// The Amazon Resource Name (ARN) of the primary broker that is used to
    /// replicate data from in a data replication pair, and is applied to the
    /// replica broker. Must be set when dataReplicationMode is set to CRDR.
    data_replication_primary_broker_arn: ?[]const u8 = null,

    /// Required. The broker's deployment mode.
    deployment_mode: DeploymentMode,

    /// Encryption options for the broker.
    encryption_options: ?EncryptionOptions = null,

    /// Required. The type of broker engine. Currently, Amazon MQ supports ACTIVEMQ
    /// and RABBITMQ.
    engine_type: EngineType,

    /// The broker engine version. Defaults to the latest available version for the
    /// specified broker engine type. For more information, see the [ActiveMQ
    /// version
    /// management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/activemq-version-management.html) and the [RabbitMQ version management](https://docs.aws.amazon.com//amazon-mq/latest/developer-guide/rabbitmq-version-management.html) sections in the Amazon MQ Developer Guide.
    engine_version: ?[]const u8 = null,

    /// Required. The broker's instance type.
    host_instance_type: []const u8,

    /// Optional. The metadata of the LDAP server used to authenticate and authorize
    /// connections to the broker. Does not apply to RabbitMQ brokers.
    ldap_server_metadata: ?LdapServerMetadataInput = null,

    /// Enables Amazon CloudWatch logging for brokers.
    logs: ?Logs = null,

    /// The parameters that determine the WeeklyStartTime.
    maintenance_window_start_time: ?WeeklyStartTime = null,

    /// Enables connections from applications outside of the VPC that hosts the
    /// broker's subnets. Set to false by default, if no value is provided.
    publicly_accessible: bool,

    /// The list of rules (1 minimum, 125 maximum) that authorize connections to
    /// brokers.
    security_groups: ?[]const []const u8 = null,

    /// The broker's storage type.
    storage_type: ?BrokerStorageType = null,

    /// The list of groups that define which subnets and IP ranges the broker can
    /// use from different Availability Zones. If you specify more than one subnet,
    /// the subnets must be in different Availability Zones. Amazon MQ will not be
    /// able to create VPC endpoints for your broker with multiple subnets in the
    /// same Availability Zone. A SINGLE_INSTANCE deployment requires one subnet
    /// (for example, the default subnet). An ACTIVE_STANDBY_MULTI_AZ Amazon MQ for
    /// ActiveMQ deployment requires two subnets. A CLUSTER_MULTI_AZ Amazon MQ for
    /// RabbitMQ deployment has no subnet requirements when deployed with public
    /// accessibility. Deployment without public accessibility requires at least one
    /// subnet.
    ///
    /// If you specify subnets in a [shared
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-sharing.html) for
    /// a RabbitMQ broker, the associated VPC to which the specified subnets belong
    /// must be owned by your Amazon Web Services account. Amazon MQ will not be
    /// able to create VPC endpoints in VPCs that are not owned by your Amazon Web
    /// Services account.
    subnet_ids: ?[]const []const u8 = null,

    /// Create tags when creating the broker.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The list of broker users (persons or applications) who can access queues and
    /// topics. For Amazon MQ for RabbitMQ brokers, an administrative user is
    /// required if using simple authentication and authorization. For brokers using
    /// OAuth2, this user is optional. When provided, one and only one
    /// administrative user is accepted and created when a broker is first
    /// provisioned. All subsequent broker users are created by making RabbitMQ API
    /// calls directly to brokers or via the RabbitMQ web console.
    users: ?[]const User = null,

    pub const json_field_names = .{
        .authentication_strategy = "AuthenticationStrategy",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .broker_name = "BrokerName",
        .configuration = "Configuration",
        .creator_request_id = "CreatorRequestId",
        .data_replication_mode = "DataReplicationMode",
        .data_replication_primary_broker_arn = "DataReplicationPrimaryBrokerArn",
        .deployment_mode = "DeploymentMode",
        .encryption_options = "EncryptionOptions",
        .engine_type = "EngineType",
        .engine_version = "EngineVersion",
        .host_instance_type = "HostInstanceType",
        .ldap_server_metadata = "LdapServerMetadata",
        .logs = "Logs",
        .maintenance_window_start_time = "MaintenanceWindowStartTime",
        .publicly_accessible = "PubliclyAccessible",
        .security_groups = "SecurityGroups",
        .storage_type = "StorageType",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
        .users = "Users",
    };
};

pub const CreateBrokerOutput = struct {
    /// The broker's Amazon Resource Name (ARN).
    broker_arn: ?[]const u8 = null,

    /// The unique ID that Amazon MQ generates for the broker.
    broker_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .broker_arn = "BrokerArn",
        .broker_id = "BrokerId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBrokerInput, options: Options) !CreateBrokerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mq");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateBrokerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mq", "mq", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/brokers";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.authentication_strategy) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AuthenticationStrategy\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.auto_minor_version_upgrade) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AutoMinorVersionUpgrade\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"BrokerName\":");
    try aws.json.writeValue(@TypeOf(input.broker_name), input.broker_name, alloc, &body_buf);
    has_prev = true;
    if (input.configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Configuration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.creator_request_id) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CreatorRequestId\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.data_replication_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DataReplicationMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.data_replication_primary_broker_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DataReplicationPrimaryBrokerArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"DeploymentMode\":");
    try aws.json.writeValue(@TypeOf(input.deployment_mode), input.deployment_mode, alloc, &body_buf);
    has_prev = true;
    if (input.encryption_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EncryptionOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"EngineType\":");
    try aws.json.writeValue(@TypeOf(input.engine_type), input.engine_type, alloc, &body_buf);
    has_prev = true;
    if (input.engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EngineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"HostInstanceType\":");
    try aws.json.writeValue(@TypeOf(input.host_instance_type), input.host_instance_type, alloc, &body_buf);
    has_prev = true;
    if (input.ldap_server_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LdapServerMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.logs) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Logs\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.maintenance_window_start_time) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaintenanceWindowStartTime\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"PubliclyAccessible\":");
    try aws.json.writeValue(@TypeOf(input.publicly_accessible), input.publicly_accessible, alloc, &body_buf);
    has_prev = true;
    if (input.security_groups) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SecurityGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.storage_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"StorageType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.subnet_ids) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SubnetIds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.users) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Users\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateBrokerOutput {
    var result: CreateBrokerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBrokerOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdvancedSecurityOptionsInput = @import("advanced_security_options_input.zig").AdvancedSecurityOptionsInput;
const AutoTuneOptions = @import("auto_tune_options.zig").AutoTuneOptions;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const ElasticsearchClusterConfig = @import("elasticsearch_cluster_config.zig").ElasticsearchClusterConfig;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const ElasticsearchDomainConfig = @import("elasticsearch_domain_config.zig").ElasticsearchDomainConfig;
const DryRunResults = @import("dry_run_results.zig").DryRunResults;

pub const UpdateElasticsearchDomainConfigInput = struct {
    /// IAM access policy as a JSON-formatted string.
    access_policies: ?[]const u8 = null,

    /// Modifies the advanced option to allow references to indices in an HTTP
    /// request body. Must be `false` when configuring access to individual
    /// sub-resources. By default, the value is `true`.
    /// See [Configuration Advanced
    /// Options](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-advanced-options) for more information.
    advanced_options: ?[]const aws.map.StringMapEntry = null,

    /// Specifies advanced security options.
    advanced_security_options: ?AdvancedSecurityOptionsInput = null,

    /// Specifies Auto-Tune options.
    auto_tune_options: ?AutoTuneOptions = null,

    /// Options to specify the Cognito user and identity pools for Kibana
    /// authentication. For more information, see [Amazon Cognito Authentication for
    /// Kibana](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html).
    cognito_options: ?CognitoOptions = null,

    /// Options to specify configuration that will be applied to the domain
    /// endpoint.
    domain_endpoint_options: ?DomainEndpointOptions = null,

    /// The name of the Elasticsearch domain that you are updating.
    domain_name: []const u8,

    /// This flag, when set to True, specifies whether the
    /// `UpdateElasticsearchDomain` request should return the results of validation
    /// checks without actually applying the change.
    /// This flag, when set to True, specifies the deployment mechanism through
    /// which the update shall be applied on the domain.
    /// This will not actually perform the Update.
    dry_run: ?bool = null,

    /// Specify the type and size of the EBS volume that you want to use.
    ebs_options: ?EBSOptions = null,

    /// The type and number of instances to instantiate for the domain cluster.
    elasticsearch_cluster_config: ?ElasticsearchClusterConfig = null,

    /// Specifies the Encryption At Rest Options.
    encryption_at_rest_options: ?EncryptionAtRestOptions = null,

    /// Map of `LogType` and `LogPublishingOption`, each containing options to
    /// publish a given type of Elasticsearch log.
    log_publishing_options: ?[]const aws.map.MapEntry(LogPublishingOption) = null,

    /// Specifies the NodeToNodeEncryptionOptions.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptions = null,

    /// Option to set the time, in UTC format, for the daily automated snapshot.
    /// Default value is `0` hours.
    snapshot_options: ?SnapshotOptions = null,

    /// Options to specify the subnets and security groups for VPC endpoint. For
    /// more information, see [Creating a
    /// VPC](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html#es-creating-vpc) in *VPC Endpoints for Amazon Elasticsearch Service Domains*
    vpc_options: ?VPCOptions = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .auto_tune_options = "AutoTuneOptions",
        .cognito_options = "CognitoOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_name = "DomainName",
        .dry_run = "DryRun",
        .ebs_options = "EBSOptions",
        .elasticsearch_cluster_config = "ElasticsearchClusterConfig",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .snapshot_options = "SnapshotOptions",
        .vpc_options = "VPCOptions",
    };
};

pub const UpdateElasticsearchDomainConfigOutput = struct {
    /// The status of the updated Elasticsearch domain.
    domain_config: ?ElasticsearchDomainConfig = null,

    /// Contains result of DryRun.
    dry_run_results: ?DryRunResults = null,

    pub const json_field_names = .{
        .domain_config = "DomainConfig",
        .dry_run_results = "DryRunResults",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateElasticsearchDomainConfigInput, options: Options) !UpdateElasticsearchDomainConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "elasticsearchservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateElasticsearchDomainConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticsearchservice", "Elasticsearch Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/2015-01-01/es/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_policies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AccessPolicies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.advanced_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdvancedOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.advanced_security_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdvancedSecurityOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auto_tune_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutoTuneOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cognito_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CognitoOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.domain_endpoint_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DomainEndpointOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ebs_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EBSOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.elasticsearch_cluster_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ElasticsearchClusterConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_at_rest_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionAtRestOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_publishing_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LogPublishingOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.node_to_node_encryption_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NodeToNodeEncryptionOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.snapshot_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnapshotOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.vpc_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"VPCOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateElasticsearchDomainConfigOutput {
    var result: UpdateElasticsearchDomainConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateElasticsearchDomainConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BaseException")) {
        return .{ .arena = arena, .kind = .{ .base_exception = .{
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
    if (std.mem.eql(u8, error_code, "DisabledOperationException")) {
        return .{ .arena = arena, .kind = .{ .disabled_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTypeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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

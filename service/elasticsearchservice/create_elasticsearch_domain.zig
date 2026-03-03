const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdvancedSecurityOptionsInput = @import("advanced_security_options_input.zig").AdvancedSecurityOptionsInput;
const AutoTuneOptionsInput = @import("auto_tune_options_input.zig").AutoTuneOptionsInput;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const ElasticsearchClusterConfig = @import("elasticsearch_cluster_config.zig").ElasticsearchClusterConfig;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const Tag = @import("tag.zig").Tag;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const ElasticsearchDomainStatus = @import("elasticsearch_domain_status.zig").ElasticsearchDomainStatus;

pub const CreateElasticsearchDomainInput = struct {
    /// IAM access policy as a JSON-formatted string.
    access_policies: ?[]const u8 = null,

    /// Option to allow references to indices in an HTTP request body. Must be
    /// `false` when configuring access to individual sub-resources. By default, the
    /// value is `true`.
    /// See [Configuration Advanced
    /// Options](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-advanced-options) for more information.
    advanced_options: ?[]const aws.map.StringMapEntry = null,

    /// Specifies advanced security options.
    advanced_security_options: ?AdvancedSecurityOptionsInput = null,

    /// Specifies Auto-Tune options.
    auto_tune_options: ?AutoTuneOptionsInput = null,

    /// Options to specify the Cognito user and identity pools for Kibana
    /// authentication. For more information, see [Amazon Cognito Authentication for
    /// Kibana](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html).
    cognito_options: ?CognitoOptions = null,

    /// Options to specify configuration that will be applied to the domain
    /// endpoint.
    domain_endpoint_options: ?DomainEndpointOptions = null,

    /// The name of the Elasticsearch domain that you are creating. Domain names are
    /// unique across the domains owned by an account within an AWS region. Domain
    /// names must start with a lowercase letter and can contain the following
    /// characters: a-z (lowercase), 0-9, and - (hyphen).
    domain_name: []const u8,

    /// Options to enable, disable and specify the type and size of EBS storage
    /// volumes.
    ebs_options: ?EBSOptions = null,

    /// Configuration options for an Elasticsearch domain. Specifies the instance
    /// type and number of instances in the domain cluster.
    elasticsearch_cluster_config: ?ElasticsearchClusterConfig = null,

    /// String of format X.Y to specify version for the Elasticsearch domain eg.
    /// "1.5" or "2.3". For more information,
    /// see [Creating Elasticsearch
    /// Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomains) in the *Amazon Elasticsearch Service Developer Guide*.
    elasticsearch_version: ?[]const u8 = null,

    /// Specifies the Encryption At Rest Options.
    encryption_at_rest_options: ?EncryptionAtRestOptions = null,

    /// Map of `LogType` and `LogPublishingOption`, each containing options to
    /// publish a given type of Elasticsearch log.
    log_publishing_options: ?[]const aws.map.MapEntry(LogPublishingOption) = null,

    /// Specifies the NodeToNodeEncryptionOptions.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptions = null,

    /// Option to set time, in UTC format, of the daily automated snapshot. Default
    /// value is 0 hours.
    snapshot_options: ?SnapshotOptions = null,

    /// A list of `Tag` added during domain creation.
    tag_list: ?[]const Tag = null,

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
        .ebs_options = "EBSOptions",
        .elasticsearch_cluster_config = "ElasticsearchClusterConfig",
        .elasticsearch_version = "ElasticsearchVersion",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .snapshot_options = "SnapshotOptions",
        .tag_list = "TagList",
        .vpc_options = "VPCOptions",
    };
};

pub const CreateElasticsearchDomainOutput = struct {
    /// The status of the newly created Elasticsearch domain.
    domain_status: ?ElasticsearchDomainStatus = null,

    pub const json_field_names = .{
        .domain_status = "DomainStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateElasticsearchDomainInput, options: Options) !CreateElasticsearchDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateElasticsearchDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticsearchservice", "Elasticsearch Service", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-01-01/es/domain";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
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
    if (input.elasticsearch_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ElasticsearchVersion\":");
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
    if (input.tag_list) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TagList\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateElasticsearchDomainOutput {
    var result: CreateElasticsearchDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateElasticsearchDomainOutput, body, allocator);
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

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedSecurityOptionsInput = @import("advanced_security_options_input.zig").AdvancedSecurityOptionsInput;
const AutomatedSnapshotPauseRequestOptions = @import("automated_snapshot_pause_request_options.zig").AutomatedSnapshotPauseRequestOptions;
const AutoTuneOptionsInput = @import("auto_tune_options_input.zig").AutoTuneOptionsInput;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DeploymentStrategyOptions = @import("deployment_strategy_options.zig").DeploymentStrategyOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const ElasticsearchClusterConfig = @import("elasticsearch_cluster_config.zig").ElasticsearchClusterConfig;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const DomainEngineMode = @import("domain_engine_mode.zig").DomainEngineMode;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const Tag = @import("tag.zig").Tag;
const DomainUseCase = @import("domain_use_case.zig").DomainUseCase;
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

    /// Specifies the automated snapshot pause options for the domain.
    ///
    /// Suspending snapshots reduces data protection. You cannot restore your domain
    /// to
    /// points in time when snapshots are suspended. Use this feature only for
    /// short-term
    /// operational needs such as migrations or maintenance windows.
    ///
    /// Maximum suspension duration: 3 days.
    automated_snapshot_pause_options: ?AutomatedSnapshotPauseRequestOptions = null,

    /// Specifies Auto-Tune options.
    auto_tune_options: ?AutoTuneOptionsInput = null,

    /// Options to specify the Cognito user and identity pools for Kibana
    /// authentication. For more information, see [Amazon Cognito Authentication for
    /// Kibana](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-cognito-auth.html).
    cognito_options: ?CognitoOptions = null,

    /// Specifies the deployment strategy options.
    deployment_strategy_options: ?DeploymentStrategyOptions = null,

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

    /// The engine mode for the domain. For valid values and requirements, see
    /// `DomainEngineMode`.
    engine_mode: ?DomainEngineMode = null,

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

    /// The primary use case for the domain. For valid values, see `DomainUseCase`.
    use_case: ?DomainUseCase = null,

    /// Options to specify the subnets and security groups for VPC endpoint. For
    /// more information, see [Creating a
    /// VPC](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html#es-creating-vpc) in *VPC Endpoints for Amazon Elasticsearch Service Domains*
    vpc_options: ?VPCOptions = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .automated_snapshot_pause_options = "AutomatedSnapshotPauseOptions",
        .auto_tune_options = "AutoTuneOptions",
        .cognito_options = "CognitoOptions",
        .deployment_strategy_options = "DeploymentStrategyOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_name = "DomainName",
        .ebs_options = "EBSOptions",
        .elasticsearch_cluster_config = "ElasticsearchClusterConfig",
        .elasticsearch_version = "ElasticsearchVersion",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .engine_mode = "EngineMode",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .snapshot_options = "SnapshotOptions",
        .tag_list = "TagList",
        .use_case = "UseCase",
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateElasticsearchDomainInput, options: CallOptions) !CreateElasticsearchDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateElasticsearchDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/domain";

    var body_buf: std.ArrayList(u8) = .empty;
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
    if (input.automated_snapshot_pause_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AutomatedSnapshotPauseOptions\":");
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
    if (input.deployment_strategy_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeploymentStrategyOptions\":");
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
    if (input.engine_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EngineMode\":");
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
    if (input.use_case) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UseCase\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateElasticsearchDomainOutput {
    const result: CreateElasticsearchDomainOutput = try aws.json.parseJsonObject(
        CreateElasticsearchDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedSecurityOptionsInput = @import("advanced_security_options_input.zig").AdvancedSecurityOptionsInput;
const AIMLOptionsInput = @import("aiml_options_input.zig").AIMLOptionsInput;
const AutomatedSnapshotPauseRequestOptions = @import("automated_snapshot_pause_request_options.zig").AutomatedSnapshotPauseRequestOptions;
const AutoTuneOptionsInput = @import("auto_tune_options_input.zig").AutoTuneOptionsInput;
const ClusterConfig = @import("cluster_config.zig").ClusterConfig;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DeploymentStrategyOptions = @import("deployment_strategy_options.zig").DeploymentStrategyOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const EngineMode = @import("engine_mode.zig").EngineMode;
const IdentityCenterOptionsInput = @import("identity_center_options_input.zig").IdentityCenterOptionsInput;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const OffPeakWindowOptions = @import("off_peak_window_options.zig").OffPeakWindowOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const SoftwareUpdateOptions = @import("software_update_options.zig").SoftwareUpdateOptions;
const Tag = @import("tag.zig").Tag;
const DomainUseCase = @import("domain_use_case.zig").DomainUseCase;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const DomainStatus = @import("domain_status.zig").DomainStatus;

pub const CreateDomainInput = struct {
    /// Identity and Access Management (IAM) policy document specifying the access
    /// policies
    /// for the new domain.
    access_policies: ?[]const u8 = null,

    /// Key-value pairs to specify advanced configuration options. The following
    /// key-value
    /// pairs are supported:
    ///
    /// * `"rest.action.multi.allow_explicit_index": "true" | "false"` - Note
    /// the use of a string rather than a boolean. Specifies whether explicit
    /// references
    /// to indexes are allowed inside the body of HTTP requests. If you want to
    /// configure access policies for domain sub-resources, such as specific indexes
    /// and
    /// domain APIs, you must disable this property. Default is true.
    ///
    /// * `"indices.fielddata.cache.size": "80" ` - Note the use of a string
    /// rather than a boolean. Specifies the percentage of heap space allocated to
    /// field
    /// data. Default is unbounded.
    ///
    /// * `"indices.query.bool.max_clause_count": "1024"` - Note the use of a
    /// string rather than a boolean. Specifies the maximum number of clauses
    /// allowed in
    /// a Lucene boolean query. Default is 1,024. Queries with more than the
    /// permitted
    /// number of clauses result in a `TooManyClauses` error.
    ///
    /// * `"override_main_response_version": "true" | "false"` - Note the use
    /// of a string rather than a boolean. Specifies whether the domain reports its
    /// version as 7.10 to allow Elasticsearch OSS clients and plugins to continue
    /// working with it. Default is false when creating a domain and true when
    /// upgrading
    /// a domain.
    ///
    /// For more information, see [Advanced cluster
    /// parameters](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html#createdomain-configure-advanced-options).
    advanced_options: ?[]const aws.map.StringMapEntry = null,

    /// Options for fine-grained access control.
    advanced_security_options: ?AdvancedSecurityOptionsInput = null,

    /// Options for all machine learning features for the specified domain.
    aiml_options: ?AIMLOptionsInput = null,

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

    /// Options for Auto-Tune.
    auto_tune_options: ?AutoTuneOptionsInput = null,

    /// Container for the cluster configuration of a domain.
    cluster_config: ?ClusterConfig = null,

    /// Key-value pairs to configure Amazon Cognito authentication. For more
    /// information, see
    /// [Configuring Amazon
    /// Cognito authentication for OpenSearch
    /// Dashboards](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/cognito-auth.html).
    cognito_options: ?CognitoOptions = null,

    /// Specifies the deployment strategy options for the domain.
    deployment_strategy_options: ?DeploymentStrategyOptions = null,

    /// Additional options for the domain endpoint, such as whether to require HTTPS
    /// for all
    /// traffic.
    domain_endpoint_options: ?DomainEndpointOptions = null,

    /// Name of the OpenSearch Service domain to create. Domain names are unique
    /// across the
    /// domains owned by an account within an Amazon Web Services Region.
    domain_name: []const u8,

    /// Container for the parameters required to enable EBS-based storage for an
    /// OpenSearch
    /// Service domain.
    ebs_options: ?EBSOptions = null,

    /// Key-value pairs to enable encryption at rest.
    encryption_at_rest_options: ?EncryptionAtRestOptions = null,

    /// The engine mode for the domain. For valid values and requirements, see
    /// `EngineMode`.
    engine_mode: ?EngineMode = null,

    /// String of format Elasticsearch_X.Y or OpenSearch_X.Y to specify the engine
    /// version for
    /// the OpenSearch Service domain. For example, `OpenSearch_1.0` or
    /// `Elasticsearch_7.9`. For more information, see [Creating and managing Amazon
    /// OpenSearch Service
    /// domains](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html#createdomains).
    engine_version: ?[]const u8 = null,

    /// Configuration options for enabling and managing IAM Identity Center
    /// integration within
    /// a domain.
    identity_center_options: ?IdentityCenterOptionsInput = null,

    /// Specify either dual stack or IPv4 as your IP address type. Dual stack allows
    /// you to
    /// share domain resources across IPv4 and IPv6 address types, and is the
    /// recommended
    /// option. If you set your IP address type to dual stack, you can't change your
    /// address
    /// type later.
    ip_address_type: ?IPAddressType = null,

    /// Key-value pairs to configure log publishing.
    log_publishing_options: ?[]const aws.map.MapEntry(LogPublishingOption) = null,

    /// Enables node-to-node encryption.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptions = null,

    /// Specifies a daily 10-hour time block during which OpenSearch Service can
    /// perform
    /// configuration changes on the domain, including service software updates and
    /// Auto-Tune
    /// enhancements that require a blue/green deployment. If no options are
    /// specified, the
    /// default start time of 10:00 P.M. local time (for the Region that the domain
    /// is created
    /// in) is used.
    off_peak_window_options: ?OffPeakWindowOptions = null,

    /// DEPRECATED. Container for the parameters required to configure automated
    /// snapshots of domain
    /// indexes.
    snapshot_options: ?SnapshotOptions = null,

    /// Software update options for the domain.
    software_update_options: ?SoftwareUpdateOptions = null,

    /// List of tags to add to the domain upon creation.
    tag_list: ?[]const Tag = null,

    /// The primary use case for the domain. For valid values, see `DomainUseCase`.
    use_case: ?DomainUseCase = null,

    /// Container for the values required to configure VPC access domains. If you
    /// don't specify
    /// these values, OpenSearch Service creates the domain with a public endpoint.
    /// For more information,
    /// see [Launching
    /// your Amazon OpenSearch Service domains using a
    /// VPC](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/vpc.html).
    vpc_options: ?VPCOptions = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .aiml_options = "AIMLOptions",
        .automated_snapshot_pause_options = "AutomatedSnapshotPauseOptions",
        .auto_tune_options = "AutoTuneOptions",
        .cluster_config = "ClusterConfig",
        .cognito_options = "CognitoOptions",
        .deployment_strategy_options = "DeploymentStrategyOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_name = "DomainName",
        .ebs_options = "EBSOptions",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .engine_mode = "EngineMode",
        .engine_version = "EngineVersion",
        .identity_center_options = "IdentityCenterOptions",
        .ip_address_type = "IPAddressType",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .off_peak_window_options = "OffPeakWindowOptions",
        .snapshot_options = "SnapshotOptions",
        .software_update_options = "SoftwareUpdateOptions",
        .tag_list = "TagList",
        .use_case = "UseCase",
        .vpc_options = "VPCOptions",
    };
};

pub const CreateDomainOutput = struct {
    /// The status of the newly created domain.
    domain_status: ?DomainStatus = null,

    pub const json_field_names = .{
        .domain_status = "DomainStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDomainInput, options: CallOptions) !CreateDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/domain";

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
    if (input.aiml_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AIMLOptions\":");
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
    if (input.cluster_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClusterConfig\":");
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
    if (input.engine_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EngineVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.identity_center_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IdentityCenterOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IPAddressType\":");
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
    if (input.off_peak_window_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OffPeakWindowOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.snapshot_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnapshotOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.software_update_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SoftwareUpdateOptions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDomainOutput {
    const result: CreateDomainOutput = try aws.json.parseJsonObject(
        CreateDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

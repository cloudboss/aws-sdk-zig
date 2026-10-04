const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdvancedSecurityOptionsInput = @import("advanced_security_options_input.zig").AdvancedSecurityOptionsInput;
const AIMLOptionsInput = @import("aiml_options_input.zig").AIMLOptionsInput;
const AutomatedSnapshotPauseRequestOptions = @import("automated_snapshot_pause_request_options.zig").AutomatedSnapshotPauseRequestOptions;
const AutoTuneOptions = @import("auto_tune_options.zig").AutoTuneOptions;
const ClusterConfig = @import("cluster_config.zig").ClusterConfig;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DeploymentStrategyOptions = @import("deployment_strategy_options.zig").DeploymentStrategyOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const DryRunMode = @import("dry_run_mode.zig").DryRunMode;
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
const DomainUseCase = @import("domain_use_case.zig").DomainUseCase;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const DomainConfig = @import("domain_config.zig").DomainConfig;
const DryRunProgressStatus = @import("dry_run_progress_status.zig").DryRunProgressStatus;
const DryRunResults = @import("dry_run_results.zig").DryRunResults;

pub const UpdateDomainConfigInput = struct {
    /// A list of advisory warning codes to accept for this configuration change. By
    /// default, any advisory warning blocks the change. Include the code of each
    /// warning you want to accept so the change can proceed. You can find warning
    /// codes in the`ValidationFailures` list returned by
    /// `DescribeDomainChangeProgress`and `DescribeDryRunProgress`. Critical
    /// validation failures cannot be accepted and always block the change. If you
    /// omit this parameter or pass an empty list, all warnings block the change.
    /// For more information, see [Validating a domain
    /// update](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-configuration-changes#validation-check).
    accepted_warnings: ?[]const []const u8 = null,

    /// Identity and Access Management (IAM) access policy as a JSON-formatted
    /// string.
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
    auto_tune_options: ?AutoTuneOptions = null,

    /// Changes that you want to make to the cluster configuration, such as the
    /// instance type
    /// and number of EC2 instances.
    cluster_config: ?ClusterConfig = null,

    /// Key-value pairs to configure Amazon Cognito authentication for OpenSearch
    /// Dashboards.
    cognito_options: ?CognitoOptions = null,

    /// Specifies the deployment strategy options for the domain.
    deployment_strategy_options: ?DeploymentStrategyOptions = null,

    /// Additional options for the domain endpoint, such as whether to require HTTPS
    /// for all
    /// traffic.
    domain_endpoint_options: ?DomainEndpointOptions = null,

    /// The name of the domain that you're updating.
    domain_name: []const u8,

    /// This flag, when set to True, specifies whether the `UpdateDomain` request
    /// should return the results of a dry run analysis without actually applying
    /// the change. A
    /// dry run determines what type of deployment the update will cause.
    dry_run: ?bool = null,

    /// The type of dry run to perform.
    ///
    /// * `Basic` only returns the type of deployment (blue/green or dynamic)
    /// that the update will cause.
    ///
    /// * `Verbose` runs an additional check to validate the changes you're
    /// making. For more information, see [Validating a domain
    /// update](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-configuration-changes#validation-check).
    dry_run_mode: ?DryRunMode = null,

    /// The type and size of the EBS volume to attach to instances in the domain.
    ebs_options: ?EBSOptions = null,

    /// Encryption at rest options for the domain.
    encryption_at_rest_options: ?EncryptionAtRestOptions = null,

    /// The engine mode for the domain. The engine mode can't be changed after the
    /// domain is created. For valid values, see `EngineMode`.
    engine_mode: ?EngineMode = null,

    identity_center_options: ?IdentityCenterOptionsInput = null,

    /// Specify either dual stack or IPv4 as your IP address type. Dual stack allows
    /// you to
    /// share domain resources across IPv4 and IPv6 address types, and is the
    /// recommended
    /// option. If your IP address type is currently set to dual stack, you can't
    /// change it.
    ip_address_type: ?IPAddressType = null,

    /// Options to publish OpenSearch logs to Amazon CloudWatch Logs.
    log_publishing_options: ?[]const aws.map.MapEntry(LogPublishingOption) = null,

    /// Node-to-node encryption options for the domain.
    node_to_node_encryption_options: ?NodeToNodeEncryptionOptions = null,

    /// Off-peak window options for the domain.
    off_peak_window_options: ?OffPeakWindowOptions = null,

    /// Option to set the time, in UTC format, for the daily automated snapshot.
    /// Default value
    /// is `0` hours.
    snapshot_options: ?SnapshotOptions = null,

    /// Service software update options for the domain.
    software_update_options: ?SoftwareUpdateOptions = null,

    /// The primary use case for the domain. For valid values, see `DomainUseCase`.
    use_case: ?DomainUseCase = null,

    /// Options to specify the subnets and security groups for a VPC endpoint. For
    /// more
    /// information, see [Launching your Amazon
    /// OpenSearch Service domains using a
    /// VPC](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/vpc.html).
    vpc_options: ?VPCOptions = null,

    pub const json_field_names = .{
        .accepted_warnings = "AcceptedWarnings",
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
        .dry_run = "DryRun",
        .dry_run_mode = "DryRunMode",
        .ebs_options = "EBSOptions",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .engine_mode = "EngineMode",
        .identity_center_options = "IdentityCenterOptions",
        .ip_address_type = "IPAddressType",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .off_peak_window_options = "OffPeakWindowOptions",
        .snapshot_options = "SnapshotOptions",
        .software_update_options = "SoftwareUpdateOptions",
        .use_case = "UseCase",
        .vpc_options = "VPCOptions",
    };
};

pub const UpdateDomainConfigOutput = struct {
    /// The status of the updated domain.
    domain_config: ?DomainConfig = null,

    /// The status of the dry run being performed on the domain, if any.
    dry_run_progress_status: ?DryRunProgressStatus = null,

    /// Results of the dry run performed in the update domain request.
    dry_run_results: ?DryRunResults = null,

    pub const json_field_names = .{
        .domain_config = "DomainConfig",
        .dry_run_progress_status = "DryRunProgressStatus",
        .dry_run_results = "DryRunResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainConfigInput, options: CallOptions) !UpdateDomainConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDomainConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/config");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accepted_warnings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AcceptedWarnings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.dry_run_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DryRunMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDomainConfigOutput {
    const result: UpdateDomainConfigOutput = try aws.json.parseJsonObject(
        UpdateDomainConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

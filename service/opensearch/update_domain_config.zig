const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AdvancedSecurityOptionsInput = @import("advanced_security_options_input.zig").AdvancedSecurityOptionsInput;
const AIMLOptionsInput = @import("aiml_options_input.zig").AIMLOptionsInput;
const AutoTuneOptions = @import("auto_tune_options.zig").AutoTuneOptions;
const ClusterConfig = @import("cluster_config.zig").ClusterConfig;
const CognitoOptions = @import("cognito_options.zig").CognitoOptions;
const DomainEndpointOptions = @import("domain_endpoint_options.zig").DomainEndpointOptions;
const DryRunMode = @import("dry_run_mode.zig").DryRunMode;
const EBSOptions = @import("ebs_options.zig").EBSOptions;
const EncryptionAtRestOptions = @import("encryption_at_rest_options.zig").EncryptionAtRestOptions;
const IdentityCenterOptionsInput = @import("identity_center_options_input.zig").IdentityCenterOptionsInput;
const IPAddressType = @import("ip_address_type.zig").IPAddressType;
const LogPublishingOption = @import("log_publishing_option.zig").LogPublishingOption;
const NodeToNodeEncryptionOptions = @import("node_to_node_encryption_options.zig").NodeToNodeEncryptionOptions;
const OffPeakWindowOptions = @import("off_peak_window_options.zig").OffPeakWindowOptions;
const SnapshotOptions = @import("snapshot_options.zig").SnapshotOptions;
const SoftwareUpdateOptions = @import("software_update_options.zig").SoftwareUpdateOptions;
const VPCOptions = @import("vpc_options.zig").VPCOptions;
const DomainConfig = @import("domain_config.zig").DomainConfig;
const DryRunProgressStatus = @import("dry_run_progress_status.zig").DryRunProgressStatus;
const DryRunResults = @import("dry_run_results.zig").DryRunResults;

pub const UpdateDomainConfigInput = struct {
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

    /// Options for Auto-Tune.
    auto_tune_options: ?AutoTuneOptions = null,

    /// Changes that you want to make to the cluster configuration, such as the
    /// instance type
    /// and number of EC2 instances.
    cluster_config: ?ClusterConfig = null,

    /// Key-value pairs to configure Amazon Cognito authentication for OpenSearch
    /// Dashboards.
    cognito_options: ?CognitoOptions = null,

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

    /// Options to specify the subnets and security groups for a VPC endpoint. For
    /// more
    /// information, see [Launching your Amazon
    /// OpenSearch Service domains using a
    /// VPC](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/vpc.html).
    vpc_options: ?VPCOptions = null,

    pub const json_field_names = .{
        .access_policies = "AccessPolicies",
        .advanced_options = "AdvancedOptions",
        .advanced_security_options = "AdvancedSecurityOptions",
        .aiml_options = "AIMLOptions",
        .auto_tune_options = "AutoTuneOptions",
        .cluster_config = "ClusterConfig",
        .cognito_options = "CognitoOptions",
        .domain_endpoint_options = "DomainEndpointOptions",
        .domain_name = "DomainName",
        .dry_run = "DryRun",
        .dry_run_mode = "DryRunMode",
        .ebs_options = "EBSOptions",
        .encryption_at_rest_options = "EncryptionAtRestOptions",
        .identity_center_options = "IdentityCenterOptions",
        .ip_address_type = "IPAddressType",
        .log_publishing_options = "LogPublishingOptions",
        .node_to_node_encryption_options = "NodeToNodeEncryptionOptions",
        .off_peak_window_options = "OffPeakWindowOptions",
        .snapshot_options = "SnapshotOptions",
        .software_update_options = "SoftwareUpdateOptions",
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDomainConfigInput, options: Options) !UpdateDomainConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "opensearch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateDomainConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("opensearch", "OpenSearch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2021-01-01/opensearch/domain/");
    try path_buf.appendSlice(alloc, input.domain_name);
    try path_buf.appendSlice(alloc, "/config");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.access_policies) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AccessPolicies\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.advanced_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdvancedOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.advanced_security_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AdvancedSecurityOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.aiml_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AIMLOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.auto_tune_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"AutoTuneOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.cluster_config) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ClusterConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.cognito_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CognitoOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.domain_endpoint_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DomainEndpointOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.dry_run_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DryRunMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ebs_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EBSOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.encryption_at_rest_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"EncryptionAtRestOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.identity_center_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IdentityCenterOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IPAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.log_publishing_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"LogPublishingOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.node_to_node_encryption_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"NodeToNodeEncryptionOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.off_peak_window_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"OffPeakWindowOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.snapshot_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SnapshotOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.software_update_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SoftwareUpdateOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.vpc_options) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"VPCOptions\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateDomainConfigOutput {
    var result: UpdateDomainConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateDomainConfigOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "DependencyFailureException")) {
        return .{ .arena = arena, .kind = .{ .dependency_failure_exception = .{
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
    if (std.mem.eql(u8, error_code, "SlotNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .slot_not_available_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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

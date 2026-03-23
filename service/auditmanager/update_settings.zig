const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AssessmentReportsDestination = @import("assessment_reports_destination.zig").AssessmentReportsDestination;
const DefaultExportDestination = @import("default_export_destination.zig").DefaultExportDestination;
const Role = @import("role.zig").Role;
const DeregistrationPolicy = @import("deregistration_policy.zig").DeregistrationPolicy;
const Settings = @import("settings.zig").Settings;

pub const UpdateSettingsInput = struct {
    /// The default S3 destination bucket for storing assessment reports.
    default_assessment_reports_destination: ?AssessmentReportsDestination = null,

    /// The default S3 destination bucket for storing evidence finder exports.
    default_export_destination: ?DefaultExportDestination = null,

    /// A list of the default audit owners.
    default_process_owners: ?[]const Role = null,

    /// The deregistration policy for your Audit Manager data. You can
    /// use this attribute to determine how your data is handled when you deregister
    /// Audit Manager.
    deregistration_policy: ?DeregistrationPolicy = null,

    /// Specifies whether the evidence finder feature is enabled. Change this
    /// attribute to
    /// enable or disable evidence finder.
    ///
    /// When you use this attribute to disable evidence finder, Audit Manager
    /// deletes the
    /// event data store that’s used to query your evidence data. As a result, you
    /// can’t
    /// re-enable evidence finder and use the feature again. Your only alternative
    /// is to
    /// [deregister](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_DeregisterAccount.html) and then [re-register](https://docs.aws.amazon.com/audit-manager/latest/APIReference/API_RegisterAccount.html)
    /// Audit Manager.
    evidence_finder_enabled: ?bool = null,

    /// The KMS key details.
    kms_key: ?[]const u8 = null,

    /// The Amazon Simple Notification Service (Amazon SNS) topic that Audit Manager
    /// sends
    /// notifications to.
    sns_topic: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_assessment_reports_destination = "defaultAssessmentReportsDestination",
        .default_export_destination = "defaultExportDestination",
        .default_process_owners = "defaultProcessOwners",
        .deregistration_policy = "deregistrationPolicy",
        .evidence_finder_enabled = "evidenceFinderEnabled",
        .kms_key = "kmsKey",
        .sns_topic = "snsTopic",
    };
};

pub const UpdateSettingsOutput = struct {
    /// The current list of settings.
    settings: ?Settings = null,

    pub const json_field_names = .{
        .settings = "settings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSettingsInput, options: CallOptions) !UpdateSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "auditmanager");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("auditmanager", "AuditManager", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/settings";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.default_assessment_reports_destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultAssessmentReportsDestination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_export_destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultExportDestination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_process_owners) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultProcessOwners\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.deregistration_policy) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"deregistrationPolicy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evidence_finder_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evidenceFinderEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sns_topic) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"snsTopic\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSettingsOutput {
    var result: UpdateSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateSettingsOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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

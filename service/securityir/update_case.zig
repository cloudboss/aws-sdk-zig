const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CaseMetadataEntry = @import("case_metadata_entry.zig").CaseMetadataEntry;
const EngagementType = @import("engagement_type.zig").EngagementType;
const ImpactedAwsRegion = @import("impacted_aws_region.zig").ImpactedAwsRegion;
const ThreatActorIp = @import("threat_actor_ip.zig").ThreatActorIp;
const Watcher = @import("watcher.zig").Watcher;

pub const UpdateCaseInput = struct {
    /// Optional element for UpdateCase to provide content for the incident start
    /// date field.
    actual_incident_start_date: ?i64 = null,

    /// Required element for UpdateCase to identify the case ID for updates.
    case_id: []const u8,

    /// Update the case request with case metadata
    case_metadata: ?[]const CaseMetadataEntry = null,

    /// Optional element for UpdateCase to provide content for the description
    /// field.
    description: ?[]const u8 = null,

    /// Optional element for UpdateCase to provide content for the engagement type
    /// field. `Available engagement types include Security Incident |
    /// Investigation`.
    engagement_type: ?EngagementType = null,

    /// Optional element for UpdateCase to provide content to add accounts impacted.
    ///
    /// AWS account ID's may appear less than 12 characters and need to be
    /// zero-prepended. An example would be `123123123` which is nine digits, and
    /// with zero-prepend would be `000123123123`. Not zero-prepending to 12 digits
    /// could result in errors.
    impacted_accounts_to_add: ?[]const []const u8 = null,

    /// Optional element for UpdateCase to provide content to add accounts impacted.
    ///
    /// AWS account ID's may appear less than 12 characters and need to be
    /// zero-prepended. An example would be `123123123` which is nine digits, and
    /// with zero-prepend would be `000123123123`. Not zero-prepending to 12 digits
    /// could result in errors.
    impacted_accounts_to_delete: ?[]const []const u8 = null,

    /// Optional element for UpdateCase to provide content to add regions impacted.
    impacted_aws_regions_to_add: ?[]const ImpactedAwsRegion = null,

    /// Optional element for UpdateCase to provide content to remove regions
    /// impacted.
    impacted_aws_regions_to_delete: ?[]const ImpactedAwsRegion = null,

    /// Optional element for UpdateCase to provide content to add services impacted.
    impacted_services_to_add: ?[]const []const u8 = null,

    /// Optional element for UpdateCase to provide content to remove services
    /// impacted.
    impacted_services_to_delete: ?[]const []const u8 = null,

    /// Optional element for UpdateCase to provide content for the customer reported
    /// incident start date field.
    reported_incident_start_date: ?i64 = null,

    /// Optional element for UpdateCase to provide content to add additional
    /// suspicious IP addresses related to a case.
    threat_actor_ip_addresses_to_add: ?[]const ThreatActorIp = null,

    /// Optional element for UpdateCase to provide content to remove suspicious IP
    /// addresses from a case.
    threat_actor_ip_addresses_to_delete: ?[]const ThreatActorIp = null,

    /// Optional element for UpdateCase to provide content for the title field.
    title: ?[]const u8 = null,

    /// Optional element for UpdateCase to provide content to add additional
    /// watchers to a case.
    watchers_to_add: ?[]const Watcher = null,

    /// Optional element for UpdateCase to provide content to remove existing
    /// watchers from a case.
    watchers_to_delete: ?[]const Watcher = null,

    pub const json_field_names = .{
        .actual_incident_start_date = "actualIncidentStartDate",
        .case_id = "caseId",
        .case_metadata = "caseMetadata",
        .description = "description",
        .engagement_type = "engagementType",
        .impacted_accounts_to_add = "impactedAccountsToAdd",
        .impacted_accounts_to_delete = "impactedAccountsToDelete",
        .impacted_aws_regions_to_add = "impactedAwsRegionsToAdd",
        .impacted_aws_regions_to_delete = "impactedAwsRegionsToDelete",
        .impacted_services_to_add = "impactedServicesToAdd",
        .impacted_services_to_delete = "impactedServicesToDelete",
        .reported_incident_start_date = "reportedIncidentStartDate",
        .threat_actor_ip_addresses_to_add = "threatActorIpAddressesToAdd",
        .threat_actor_ip_addresses_to_delete = "threatActorIpAddressesToDelete",
        .title = "title",
        .watchers_to_add = "watchersToAdd",
        .watchers_to_delete = "watchersToDelete",
    };
};

pub const UpdateCaseOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCaseInput, options: CallOptions) !UpdateCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "security-ir");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/update-case");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.actual_incident_start_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actualIncidentStartDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.case_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"caseMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.engagement_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"engagementType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_accounts_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedAccountsToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_accounts_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedAccountsToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_aws_regions_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedAwsRegionsToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_aws_regions_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedAwsRegionsToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_services_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedServicesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_services_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedServicesToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.reported_incident_start_date) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reportedIncidentStartDate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.threat_actor_ip_addresses_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"threatActorIpAddressesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.threat_actor_ip_addresses_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"threatActorIpAddressesToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.title) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"title\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.watchers_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"watchersToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.watchers_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"watchersToDelete\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCaseOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateCaseOutput = .{};

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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "SecurityIncidentResponseNotActiveException")) {
        return .{ .arena = arena, .kind = .{ .security_incident_response_not_active_exception = .{
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

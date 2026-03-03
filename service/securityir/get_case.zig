const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CaseAttachmentAttributes = @import("case_attachment_attributes.zig").CaseAttachmentAttributes;
const CaseMetadataEntry = @import("case_metadata_entry.zig").CaseMetadataEntry;
const CaseStatus = @import("case_status.zig").CaseStatus;
const ClosureCode = @import("closure_code.zig").ClosureCode;
const EngagementType = @import("engagement_type.zig").EngagementType;
const ImpactedAwsRegion = @import("impacted_aws_region.zig").ImpactedAwsRegion;
const PendingAction = @import("pending_action.zig").PendingAction;
const ResolverType = @import("resolver_type.zig").ResolverType;
const ThreatActorIp = @import("threat_actor_ip.zig").ThreatActorIp;
const Watcher = @import("watcher.zig").Watcher;

pub const GetCaseInput = struct {
    /// Required element for GetCase to identify the requested case ID.
    case_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub const GetCaseOutput = struct {
    /// Response element for GetCase that provides the actual incident start date as
    /// identified by data analysis during the investigation.
    actual_incident_start_date: ?i64 = null,

    /// Response element for GetCase that provides the case ARN
    case_arn: ?[]const u8 = null,

    /// Response element for GetCase that provides a list of current case
    /// attachments.
    case_attachments: ?[]const CaseAttachmentAttributes = null,

    /// Case response metadata
    case_metadata: ?[]const CaseMetadataEntry = null,

    /// Response element for GetCase that provides the case status. Options for
    /// statuses include `Submitted | Detection and Analysis | Eradication,
    /// Containment and Recovery | Post-Incident Activities | Closed `
    case_status: ?CaseStatus = null,

    /// Response element for GetCase that provides the date a specified case was
    /// closed.
    closed_date: ?i64 = null,

    /// Response element for GetCase that provides the summary code for why a case
    /// was closed.
    closure_code: ?ClosureCode = null,

    /// Response element for GetCase that provides the date the case was created.
    created_date: ?i64 = null,

    /// Response element for GetCase that provides contents of the case description.
    description: ?[]const u8 = null,

    /// Response element for GetCase that provides the engagement type. Options for
    /// engagement type include `Active Security Event | Investigations`
    engagement_type: ?EngagementType = null,

    /// Response element for GetCase that provides a list of impacted accounts.
    impacted_accounts: ?[]const []const u8 = null,

    /// Response element for GetCase that provides the impacted regions.
    impacted_aws_regions: ?[]const ImpactedAwsRegion = null,

    /// Response element for GetCase that provides a list of impacted services.
    impacted_services: ?[]const []const u8 = null,

    /// Response element for GetCase that provides the date a case was last
    /// modified.
    last_updated_date: ?i64 = null,

    /// Response element for GetCase that identifies the case is waiting on customer
    /// input.
    pending_action: ?PendingAction = null,

    /// Response element for GetCase that provides the customer provided incident
    /// start date.
    reported_incident_start_date: ?i64 = null,

    /// Response element for GetCase that provides the current resolver types.
    resolver_type: ?ResolverType = null,

    /// Response element for GetCase that provides a list of suspicious IP addresses
    /// associated with unauthorized activity.
    threat_actor_ip_addresses: ?[]const ThreatActorIp = null,

    /// Response element for GetCase that provides the case title.
    title: ?[]const u8 = null,

    /// Response element for GetCase that provides a list of Watchers added to the
    /// case.
    watchers: ?[]const Watcher = null,

    pub const json_field_names = .{
        .actual_incident_start_date = "actualIncidentStartDate",
        .case_arn = "caseArn",
        .case_attachments = "caseAttachments",
        .case_metadata = "caseMetadata",
        .case_status = "caseStatus",
        .closed_date = "closedDate",
        .closure_code = "closureCode",
        .created_date = "createdDate",
        .description = "description",
        .engagement_type = "engagementType",
        .impacted_accounts = "impactedAccounts",
        .impacted_aws_regions = "impactedAwsRegions",
        .impacted_services = "impactedServices",
        .last_updated_date = "lastUpdatedDate",
        .pending_action = "pendingAction",
        .reported_incident_start_date = "reportedIncidentStartDate",
        .resolver_type = "resolverType",
        .threat_actor_ip_addresses = "threatActorIpAddresses",
        .title = "title",
        .watchers = "watchers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCaseInput, options: CallOptions) !GetCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "securityir");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityir", "Security IR", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v1/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    try path_buf.appendSlice(allocator, "/get-case");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCaseOutput {
    var result: GetCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCaseOutput, body, allocator);
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

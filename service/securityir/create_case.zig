const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EngagementType = @import("engagement_type.zig").EngagementType;
const ImpactedAwsRegion = @import("impacted_aws_region.zig").ImpactedAwsRegion;
const ResolverType = @import("resolver_type.zig").ResolverType;
const ThreatActorIp = @import("threat_actor_ip.zig").ThreatActorIp;
const Watcher = @import("watcher.zig").Watcher;

pub const CreateCaseInput = struct {
    /// The `clientToken` field is an idempotency key used to ensure that repeated
    /// attempts for a single action will be ignored by the server during retries. A
    /// caller supplied unique ID (typically a UUID) should be provided.
    client_token: ?[]const u8 = null,

    /// Required element used in combination with CreateCase
    ///
    /// to provide a description for the new case.
    description: []const u8,

    /// Required element used in combination with CreateCase to provide an
    /// engagement type for the new cases. Available engagement types include
    /// Security Incident | Investigation
    engagement_type: EngagementType,

    /// Required element used in combination with CreateCase to provide a list of
    /// impacted accounts.
    ///
    /// AWS account ID's may appear less than 12 characters and need to be
    /// zero-prepended. An example would be `123123123` which is nine digits, and
    /// with zero-prepend would be `000123123123`. Not zero-prepending to 12 digits
    /// could result in errors.
    impacted_accounts: []const []const u8,

    /// An optional element used in combination with CreateCase to provide a list of
    /// impacted regions.
    impacted_aws_regions: []const ImpactedAwsRegion = &.{},

    /// An optional element used in combination with CreateCase to provide a list of
    /// services impacted.
    impacted_services: []const []const u8 = &.{},

    /// Required element used in combination with CreateCase to provide an initial
    /// start date for the unauthorized activity.
    reported_incident_start_date: i64,

    /// Required element used in combination with CreateCase to identify the
    /// resolver type.
    resolver_type: ResolverType,

    /// An optional element used in combination with CreateCase to add customer
    /// specified tags to a case.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// An optional element used in combination with CreateCase to provide a list of
    /// suspicious internet protocol addresses associated with unauthorized
    /// activity.
    threat_actor_ip_addresses: []const ThreatActorIp = &.{},

    /// Required element used in combination with CreateCase to provide a title for
    /// the new case.
    title: []const u8,

    /// Required element used in combination with CreateCase to provide a list of
    /// entities to receive notifications for case updates.
    watchers: []const Watcher,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .engagement_type = "engagementType",
        .impacted_accounts = "impactedAccounts",
        .impacted_aws_regions = "impactedAwsRegions",
        .impacted_services = "impactedServices",
        .reported_incident_start_date = "reportedIncidentStartDate",
        .resolver_type = "resolverType",
        .tags = "tags",
        .threat_actor_ip_addresses = "threatActorIpAddresses",
        .title = "title",
        .watchers = "watchers",
    };
};

pub const CreateCaseOutput = struct {
    /// A response element providing responses for requests to CreateCase. This
    /// element responds with the case ID.
    case_id: []const u8,

    pub const json_field_names = .{
        .case_id = "caseId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCaseInput, options: Options) !CreateCaseOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityir", "Security IR", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/create-case";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"engagementType\":");
    try aws.json.writeValue(@TypeOf(input.engagement_type), input.engagement_type, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"impactedAccounts\":");
    try aws.json.writeValue(@TypeOf(input.impacted_accounts), input.impacted_accounts, alloc, &body_buf);
    has_prev = true;
    if (input.impacted_aws_regions) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"impactedAwsRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.impacted_services) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"impactedServices\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"reportedIncidentStartDate\":");
    try aws.json.writeValue(@TypeOf(input.reported_incident_start_date), input.reported_incident_start_date, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"resolverType\":");
    try aws.json.writeValue(@TypeOf(input.resolver_type), input.resolver_type, alloc, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.threat_actor_ip_addresses) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"threatActorIpAddresses\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"title\":");
    try aws.json.writeValue(@TypeOf(input.title), input.title, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"watchers\":");
    try aws.json.writeValue(@TypeOf(input.watchers), input.watchers, alloc, &body_buf);
    has_prev = true;

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateCaseOutput {
    var result: CreateCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCaseOutput, body, alloc);
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

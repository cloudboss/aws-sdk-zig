const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
    impacted_aws_regions: ?[]const ImpactedAwsRegion = null,

    /// An optional element used in combination with CreateCase to provide a list of
    /// services impacted.
    impacted_services: ?[]const []const u8 = null,

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
    threat_actor_ip_addresses: ?[]const ThreatActorIp = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCaseInput, options: CallOptions) !CreateCaseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "security-ir", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("security-ir", "Security IR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/create-case";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"description\":");
    try aws.json.writeValue(@TypeOf(input.description), input.description, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"engagementType\":");
    try aws.json.writeValue(@TypeOf(input.engagement_type), input.engagement_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"impactedAccounts\":");
    try aws.json.writeValue(@TypeOf(input.impacted_accounts), input.impacted_accounts, allocator, &body_buf);
    has_prev = true;
    if (input.impacted_aws_regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedAwsRegions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.impacted_services) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"impactedServices\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"reportedIncidentStartDate\":");
    try aws.json.writeValue(@TypeOf(input.reported_incident_start_date), input.reported_incident_start_date, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resolverType\":");
    try aws.json.writeValue(@TypeOf(input.resolver_type), input.resolver_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.threat_actor_ip_addresses) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"threatActorIpAddresses\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"title\":");
    try aws.json.writeValue(@TypeOf(input.title), input.title, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"watchers\":");
    try aws.json.writeValue(@TypeOf(input.watchers), input.watchers, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCaseOutput {
    var result: CreateCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

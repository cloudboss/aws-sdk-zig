const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Assets = @import("assets.zig").Assets;
const CloudWatchLog = @import("cloud_watch_log.zig").CloudWatchLog;
const ReportDestination = @import("report_destination.zig").ReportDestination;
const DocumentInfo = @import("document_info.zig").DocumentInfo;

pub const CreateThreatModelInput = struct {
    /// The unique identifier of the agent space to create the threat model in.
    agent_space_id: []const u8,

    /// The assets to include in the threat model.
    assets: ?Assets = null,

    /// A description of the application or system being threat modeled.
    description: ?[]const u8 = null,

    /// The CloudWatch Logs configuration for the threat model.
    log_config: ?CloudWatchLog = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The scoped documents for the agent to focus on during threat modeling.
    scope_docs: ?[]const DocumentInfo = null,

    /// The IAM service role to use for the threat model.
    service_role: []const u8,

    /// The title of the threat model.
    title: []const u8,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .assets = "assets",
        .description = "description",
        .log_config = "logConfig",
        .report_destination = "reportDestination",
        .scope_docs = "scopeDocs",
        .service_role = "serviceRole",
        .title = "title",
    };
};

pub const CreateThreatModelOutput = struct {
    /// The unique identifier of the agent space that contains the threat model.
    agent_space_id: ?[]const u8 = null,

    /// The assets included in the threat model.
    assets: ?Assets = null,

    /// The date and time the threat model was created, in UTC format.
    created_at: ?i64 = null,

    /// A description of the application or system being threat modeled.
    description: ?[]const u8 = null,

    /// The CloudWatch Logs configuration for the threat model.
    log_config: ?CloudWatchLog = null,

    /// The destination for publishing scan reports to an integrated document
    /// provider.
    report_destination: ?ReportDestination = null,

    /// The scoped documents for the agent to focus on during threat modeling.
    scope_docs: ?[]const DocumentInfo = null,

    /// The IAM service role used for the threat model.
    service_role: ?[]const u8 = null,

    /// The unique identifier of the created threat model.
    threat_model_id: []const u8,

    /// The title of the threat model.
    title: ?[]const u8 = null,

    /// The date and time the threat model was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .assets = "assets",
        .created_at = "createdAt",
        .description = "description",
        .log_config = "logConfig",
        .report_destination = "reportDestination",
        .scope_docs = "scopeDocs",
        .service_role = "serviceRole",
        .threat_model_id = "threatModelId",
        .title = "title",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateThreatModelInput, options: CallOptions) !CreateThreatModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateThreatModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateThreatModel";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentSpaceId\":");
    try aws.json.writeValue(@TypeOf(input.agent_space_id), input.agent_space_id, allocator, &body_buf);
    has_prev = true;
    if (input.assets) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"assets\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.log_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"logConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.report_destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reportDestination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scope_docs) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scopeDocs\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceRole\":");
    try aws.json.writeValue(@TypeOf(input.service_role), input.service_role, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"title\":");
    try aws.json.writeValue(@TypeOf(input.title), input.title, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateThreatModelOutput {
    const result: CreateThreatModelOutput = try aws.json.parseJsonObject(
        CreateThreatModelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

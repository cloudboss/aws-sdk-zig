const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateIntegrationDetail = @import("create_integration_detail.zig").CreateIntegrationDetail;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

pub const CreateCodeSecurityIntegrationInput = struct {
    /// The integration details specific to the repository provider type.
    details: ?CreateIntegrationDetail = null,

    /// The name of the code security integration.
    name: []const u8,

    /// The tags to apply to the code security integration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of repository provider for the integration.
    @"type": IntegrationType,

    pub const json_field_names = .{
        .details = "details",
        .name = "name",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateCodeSecurityIntegrationOutput = struct {
    /// The URL used to authorize the integration with the repository provider.
    authorization_url: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the created code security integration.
    integration_arn: []const u8,

    /// The current status of the code security integration.
    status: IntegrationStatus,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
        .integration_arn = "integrationArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCodeSecurityIntegrationInput, options: CallOptions) !CreateCodeSecurityIntegrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCodeSecurityIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/integration/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"details\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCodeSecurityIntegrationOutput {
    const result: CreateCodeSecurityIntegrationOutput = try aws.json.parseJsonObject(
        CreateCodeSecurityIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

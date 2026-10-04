const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;
const IntegrationType = @import("integration_type.zig").IntegrationType;

pub const GetCodeSecurityIntegrationInput = struct {
    /// The Amazon Resource Name (ARN) of the code security integration to retrieve.
    integration_arn: []const u8,

    /// The tags associated with the code security integration.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .integration_arn = "integrationArn",
        .tags = "tags",
    };
};

pub const GetCodeSecurityIntegrationOutput = struct {
    /// The URL used to authorize the integration with the repository provider. This
    /// is only
    /// returned if reauthorization is required to fix a connection issue.
    /// Otherwise, it is
    /// null.
    authorization_url: ?[]const u8 = null,

    /// The timestamp when the code security integration was created.
    created_on: i64,

    /// The Amazon Resource Name (ARN) of the code security integration.
    integration_arn: []const u8,

    /// The timestamp when the code security integration was last updated.
    last_update_on: i64,

    /// The name of the code security integration.
    name: []const u8,

    /// The current status of the code security integration.
    status: IntegrationStatus,

    /// The reason for the current status of the code security integration.
    status_reason: []const u8,

    /// The tags associated with the code security integration.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of repository provider for the integration.
    @"type": IntegrationType,

    pub const json_field_names = .{
        .authorization_url = "authorizationUrl",
        .created_on = "createdOn",
        .integration_arn = "integrationArn",
        .last_update_on = "lastUpdateOn",
        .name = "name",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCodeSecurityIntegrationInput, options: CallOptions) !GetCodeSecurityIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCodeSecurityIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/integration/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"integrationArn\":");
    try aws.json.writeValue(@TypeOf(input.integration_arn), input.integration_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCodeSecurityIntegrationOutput {
    const result: GetCodeSecurityIntegrationOutput = try aws.json.parseJsonObject(
        GetCodeSecurityIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateIntegrationDetails = @import("update_integration_details.zig").UpdateIntegrationDetails;
const IntegrationStatus = @import("integration_status.zig").IntegrationStatus;

pub const UpdateCodeSecurityIntegrationInput = struct {
    /// The updated integration details specific to the repository provider type.
    details: UpdateIntegrationDetails,

    /// The Amazon Resource Name (ARN) of the code security integration to update.
    integration_arn: []const u8,

    pub const json_field_names = .{
        .details = "details",
        .integration_arn = "integrationArn",
    };
};

pub const UpdateCodeSecurityIntegrationOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated code security integration.
    integration_arn: []const u8,

    /// The current status of the updated code security integration.
    status: IntegrationStatus,

    pub const json_field_names = .{
        .integration_arn = "integrationArn",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCodeSecurityIntegrationInput, options: CallOptions) !UpdateCodeSecurityIntegrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCodeSecurityIntegrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/integration/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"details\":");
    try aws.json.writeValue(@TypeOf(input.details), input.details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"integrationArn\":");
    try aws.json.writeValue(@TypeOf(input.integration_arn), input.integration_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCodeSecurityIntegrationOutput {
    const result: UpdateCodeSecurityIntegrationOutput = try aws.json.parseJsonObject(
        UpdateCodeSecurityIntegrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

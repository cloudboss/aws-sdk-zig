const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EventStatus = @import("event_status.zig").EventStatus;

pub const StartAutomationEventInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. Must be 1-64 characters long and contain only
    /// alphanumeric characters, underscores, and hyphens.
    client_token: ?[]const u8 = null,

    /// The ID of the recommended action to automate.
    recommended_action_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .recommended_action_id = "recommendedActionId",
    };
};

pub const StartAutomationEventOutput = struct {
    /// The ID of the automation event.
    event_id: ?[]const u8 = null,

    /// The current status of the automation event.
    event_status: ?EventStatus = null,

    /// The ID of the recommended action being automated.
    recommended_action_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_id = "eventId",
        .event_status = "eventStatus",
        .recommended_action_id = "recommendedActionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAutomationEventInput, options: CallOptions) !StartAutomationEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAutomationEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aco-automation", "Compute Optimizer Automation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.StartAutomationEvent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAutomationEventOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartAutomationEventOutput, body, allocator);
}

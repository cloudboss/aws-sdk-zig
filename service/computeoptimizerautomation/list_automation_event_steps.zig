const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomationEventStep = @import("automation_event_step.zig").AutomationEventStep;

pub const ListAutomationEventStepsInput = struct {
    /// The ID of the automation event.
    event_id: []const u8,

    /// The maximum number of automation event steps to return in a single response.
    /// Valid range is 1-1000.
    max_results: ?i32 = null,

    /// A token used for pagination to retrieve the next set of results when the
    /// response is truncated.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_id = "eventId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListAutomationEventStepsOutput = struct {
    /// The list of steps for the specified automation event.
    automation_event_steps: ?[]const AutomationEventStep = null,

    /// A token used for pagination. If present, indicates there are more results
    /// available and can be used in subsequent requests.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .automation_event_steps = "automationEventSteps",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAutomationEventStepsInput, options: CallOptions) !ListAutomationEventStepsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAutomationEventStepsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerAutomationService.ListAutomationEventSteps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAutomationEventStepsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAutomationEventStepsOutput, body, allocator);
}

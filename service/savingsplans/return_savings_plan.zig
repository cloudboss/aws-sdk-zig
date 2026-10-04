const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ReturnSavingsPlanInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request.
    client_token: ?[]const u8 = null,

    /// The ID of the Savings Plan.
    savings_plan_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .savings_plan_id = "savingsPlanId",
    };
};

pub const ReturnSavingsPlanOutput = struct {
    /// The ID of the Savings Plan.
    savings_plan_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .savings_plan_id = "savingsPlanId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ReturnSavingsPlanInput, options: CallOptions) !ReturnSavingsPlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "savingsplans", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ReturnSavingsPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("savingsplans", "savingsplans", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ReturnSavingsPlan";

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
    try body_buf.appendSlice(allocator, "\"savingsPlanId\":");
    try aws.json.writeValue(@TypeOf(input.savings_plan_id), input.savings_plan_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ReturnSavingsPlanOutput {
    const result: ReturnSavingsPlanOutput = try aws.json.parseJsonObject(
        ReturnSavingsPlanOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

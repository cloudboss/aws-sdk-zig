const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexingRuleValueUpdate = @import("indexing_rule_value_update.zig").IndexingRuleValueUpdate;
const IndexingRule = @import("indexing_rule.zig").IndexingRule;

pub const UpdateIndexingRuleInput = struct {
    /// Name of the indexing rule to be updated.
    name: []const u8,

    /// Rule configuration to be updated.
    rule: IndexingRuleValueUpdate,

    pub const json_field_names = .{
        .name = "Name",
        .rule = "Rule",
    };
};

pub const UpdateIndexingRuleOutput = struct {
    /// Updated indexing rule.
    indexing_rule: ?IndexingRule = null,

    pub const json_field_names = .{
        .indexing_rule = "IndexingRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateIndexingRuleInput, options: CallOptions) !UpdateIndexingRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateIndexingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateIndexingRule";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Rule\":");
    try aws.json.writeValue(@TypeOf(input.rule), input.rule, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateIndexingRuleOutput {
    const result: UpdateIndexingRuleOutput = try aws.json.parseJsonObject(
        UpdateIndexingRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

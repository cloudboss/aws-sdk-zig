const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SamplingRuleRecord = @import("sampling_rule_record.zig").SamplingRuleRecord;

pub const DeleteSamplingRuleInput = struct {
    /// The ARN of the sampling rule. Specify a rule by either name or ARN, but not
    /// both.
    rule_arn: ?[]const u8 = null,

    /// The name of the sampling rule. Specify a rule by either name or ARN, but not
    /// both.
    rule_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .rule_arn = "RuleARN",
        .rule_name = "RuleName",
    };
};

pub const DeleteSamplingRuleOutput = struct {
    /// The deleted rule definition and metadata.
    sampling_rule_record: ?SamplingRuleRecord = null,

    pub const json_field_names = .{
        .sampling_rule_record = "SamplingRuleRecord",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteSamplingRuleInput, options: CallOptions) !DeleteSamplingRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteSamplingRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DeleteSamplingRule";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.rule_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RuleARN\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.rule_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RuleName\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteSamplingRuleOutput {
    var result: DeleteSamplingRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteSamplingRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

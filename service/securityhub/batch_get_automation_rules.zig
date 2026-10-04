const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomationRulesConfig = @import("automation_rules_config.zig").AutomationRulesConfig;
const UnprocessedAutomationRule = @import("unprocessed_automation_rule.zig").UnprocessedAutomationRule;

pub const BatchGetAutomationRulesInput = struct {
    /// A list of rule ARNs to get details for.
    automation_rules_arns: []const []const u8,

    pub const json_field_names = .{
        .automation_rules_arns = "AutomationRulesArns",
    };
};

pub const BatchGetAutomationRulesOutput = struct {
    /// A list of rule details for the provided rule ARNs.
    rules: ?[]const AutomationRulesConfig = null,

    /// A list of objects containing `RuleArn`, `ErrorCode`, and `ErrorMessage`.
    /// This parameter
    /// tells you which automation rules the request didn't retrieve and why.
    unprocessed_automation_rules: ?[]const UnprocessedAutomationRule = null,

    pub const json_field_names = .{
        .rules = "Rules",
        .unprocessed_automation_rules = "UnprocessedAutomationRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetAutomationRulesInput, options: CallOptions) !BatchGetAutomationRulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetAutomationRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automationrules/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AutomationRulesArns\":");
    try aws.json.writeValue(@TypeOf(input.automation_rules_arns), input.automation_rules_arns, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetAutomationRulesOutput {
    var result: BatchGetAutomationRulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetAutomationRulesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateAutomationRulesRequestItem = @import("update_automation_rules_request_item.zig").UpdateAutomationRulesRequestItem;
const UnprocessedAutomationRule = @import("unprocessed_automation_rule.zig").UnprocessedAutomationRule;

pub const BatchUpdateAutomationRulesInput = struct {
    /// An array of ARNs for the rules that are to be updated. Optionally, you can
    /// also include
    /// `RuleStatus` and `RuleOrder`.
    update_automation_rules_request_items: []const UpdateAutomationRulesRequestItem,

    pub const json_field_names = .{
        .update_automation_rules_request_items = "UpdateAutomationRulesRequestItems",
    };
};

pub const BatchUpdateAutomationRulesOutput = struct {
    /// A list of properly processed rule ARNs.
    processed_automation_rules: ?[]const []const u8 = null,

    /// A list of objects containing `RuleArn`, `ErrorCode`, and `ErrorMessage`.
    /// This parameter
    /// tells you which automation rules the request didn't update and why.
    unprocessed_automation_rules: ?[]const UnprocessedAutomationRule = null,

    pub const json_field_names = .{
        .processed_automation_rules = "ProcessedAutomationRules",
        .unprocessed_automation_rules = "UnprocessedAutomationRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateAutomationRulesInput, options: CallOptions) !BatchUpdateAutomationRulesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateAutomationRulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/automationrules/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UpdateAutomationRulesRequestItems\":");
    try aws.json.writeValue(@TypeOf(input.update_automation_rules_request_items), input.update_automation_rules_request_items, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateAutomationRulesOutput {
    const result: BatchUpdateAutomationRulesOutput = try aws.json.parseJsonObject(
        BatchUpdateAutomationRulesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaseRuleIdentifier = @import("case_rule_identifier.zig").CaseRuleIdentifier;
const GetCaseRuleResponse = @import("get_case_rule_response.zig").GetCaseRuleResponse;
const CaseRuleError = @import("case_rule_error.zig").CaseRuleError;

pub const BatchGetCaseRuleInput = struct {
    /// A list of case rule identifiers.
    case_rules: []const CaseRuleIdentifier,

    /// Unique identifier of a Cases domain.
    domain_id: []const u8,

    pub const json_field_names = .{
        .case_rules = "caseRules",
        .domain_id = "domainId",
    };
};

pub const BatchGetCaseRuleOutput = struct {
    /// A list of detailed case rule information.
    case_rules: ?[]const GetCaseRuleResponse = null,

    /// A list of case rule errors.
    errors: ?[]const CaseRuleError = null,

    /// A list of unprocessed case rule identifiers.
    unprocessed_case_rules: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .case_rules = "caseRules",
        .errors = "errors",
        .unprocessed_case_rules = "unprocessedCaseRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCaseRuleInput, options: CallOptions) !BatchGetCaseRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cases", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCaseRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cases", "ConnectCases", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/rules-batch");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"caseRules\":");
    try aws.json.writeValue(@TypeOf(input.case_rules), input.case_rules, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCaseRuleOutput {
    var result: BatchGetCaseRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetCaseRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

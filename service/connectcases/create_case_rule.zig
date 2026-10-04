const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CaseRuleDetails = @import("case_rule_details.zig").CaseRuleDetails;

pub const CreateCaseRuleInput = struct {
    /// The description of a case rule.
    description: ?[]const u8 = null,

    /// Unique identifier of a Cases domain.
    domain_id: []const u8,

    /// Name of the case rule.
    name: []const u8,

    /// Represents what rule type should take place, under what conditions.
    rule: CaseRuleDetails,

    pub const json_field_names = .{
        .description = "description",
        .domain_id = "domainId",
        .name = "name",
        .rule = "rule",
    };
};

pub const CreateCaseRuleOutput = struct {
    /// The Amazon Resource Name (ARN) of a case rule.
    case_rule_arn: []const u8,

    /// Unique identifier of a case rule.
    case_rule_id: []const u8,

    pub const json_field_names = .{
        .case_rule_arn = "caseRuleArn",
        .case_rule_id = "caseRuleId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCaseRuleInput, options: CallOptions) !CreateCaseRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCaseRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cases", "ConnectCases", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/case-rules");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"rule\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCaseRuleOutput {
    var result: CreateCaseRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCaseRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

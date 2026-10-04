const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleAction = @import("rule_action.zig").RuleAction;
const RuleMatch = @import("rule_match.zig").RuleMatch;

pub const UpdateRuleInput = struct {
    /// Information about the action for the specified listener rule.
    action: ?RuleAction = null,

    /// The ID or ARN of the listener.
    listener_identifier: []const u8,

    /// The rule match.
    match: ?RuleMatch = null,

    /// The rule priority. A listener can't have multiple rules with the same
    /// priority.
    priority: ?i32 = null,

    /// The ID or ARN of the rule.
    rule_identifier: []const u8,

    /// The ID or ARN of the service.
    service_identifier: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .listener_identifier = "listenerIdentifier",
        .match = "match",
        .priority = "priority",
        .rule_identifier = "ruleIdentifier",
        .service_identifier = "serviceIdentifier",
    };
};

pub const UpdateRuleOutput = struct {
    /// Information about the action for the specified listener rule.
    action: ?RuleAction = null,

    /// The Amazon Resource Name (ARN) of the listener.
    arn: ?[]const u8 = null,

    /// The ID of the listener.
    id: ?[]const u8 = null,

    /// Indicates whether this is the default rule.
    is_default: ?bool = null,

    /// The rule match.
    match: ?RuleMatch = null,

    /// The name of the listener.
    name: ?[]const u8 = null,

    /// The rule priority.
    priority: ?i32 = null,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .id = "id",
        .is_default = "isDefault",
        .match = "match",
        .name = "name",
        .priority = "priority",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRuleInput, options: CallOptions) !UpdateRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
    try path_buf.appendSlice(allocator, "/listeners/");
    try path_buf.appendSlice(allocator, input.listener_identifier);
    try path_buf.appendSlice(allocator, "/rules/");
    try path_buf.appendSlice(allocator, input.rule_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"action\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.match) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"match\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.priority) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"priority\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRuleOutput {
    const result: UpdateRuleOutput = try aws.json.parseJsonObject(
        UpdateRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

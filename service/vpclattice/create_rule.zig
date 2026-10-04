const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleAction = @import("rule_action.zig").RuleAction;
const RuleMatch = @import("rule_match.zig").RuleMatch;

pub const CreateRuleInput = struct {
    /// The action for the default rule.
    action: RuleAction,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// The ID or ARN of the listener.
    listener_identifier: []const u8,

    /// The rule match.
    match: RuleMatch,

    /// The name of the rule. The name must be unique within the listener. The valid
    /// characters are a-z, 0-9, and hyphens (-). You can't use a hyphen as the
    /// first or last character, or immediately after another hyphen.
    name: []const u8,

    /// The priority assigned to the rule. Each rule for a specific listener must
    /// have a unique priority. The lower the priority number the higher the
    /// priority.
    priority: i32,

    /// The ID or ARN of the service.
    service_identifier: []const u8,

    /// The tags for the rule.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .action = "action",
        .client_token = "clientToken",
        .listener_identifier = "listenerIdentifier",
        .match = "match",
        .name = "name",
        .priority = "priority",
        .service_identifier = "serviceIdentifier",
        .tags = "tags",
    };
};

pub const CreateRuleOutput = struct {
    /// The rule action.
    action: ?RuleAction = null,

    /// The Amazon Resource Name (ARN) of the rule.
    arn: ?[]const u8 = null,

    /// The ID of the rule.
    id: ?[]const u8 = null,

    /// The rule match. The `RuleMatch` must be an `HttpMatch`. This means that the
    /// rule should be an exact match on HTTP constraints which are made up of the
    /// HTTP method, path, and header.
    match: ?RuleMatch = null,

    /// The name of the rule.
    name: ?[]const u8 = null,

    /// The priority assigned to the rule. The lower the priority number the higher
    /// the priority.
    priority: ?i32 = null,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .id = "id",
        .match = "match",
        .name = "name",
        .priority = "priority",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleInput, options: CallOptions) !CreateRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/services/");
    try path_buf.appendSlice(allocator, input.service_identifier);
    try path_buf.appendSlice(allocator, "/listeners/");
    try path_buf.appendSlice(allocator, input.listener_identifier);
    try path_buf.appendSlice(allocator, "/rules");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"match\":");
    try aws.json.writeValue(@TypeOf(input.match), input.match, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"priority\":");
    try aws.json.writeValue(@TypeOf(input.priority), input.priority, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRuleOutput {
    const result: CreateRuleOutput = try aws.json.parseJsonObject(
        CreateRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

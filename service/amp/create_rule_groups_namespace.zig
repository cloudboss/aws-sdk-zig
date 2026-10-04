const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleGroupsNamespaceStatus = @import("rule_groups_namespace_status.zig").RuleGroupsNamespaceStatus;

pub const CreateRuleGroupsNamespaceInput = struct {
    /// A unique identifier that you can provide to ensure the idempotency of the
    /// request. Case-sensitive.
    client_token: ?[]const u8 = null,

    /// The rules file to use in the new namespace.
    ///
    /// Contains the base64-encoded version of the YAML rules file.
    ///
    /// For details about the rule groups namespace structure, see
    /// [RuleGroupsNamespaceData](https://docs.aws.amazon.com/prometheus/latest/APIReference/yaml-RuleGroupsNamespaceData.html).
    data: []const u8,

    /// The name for the new rule groups namespace.
    name: []const u8,

    /// The list of tag keys and values to associate with the rule groups namespace.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the workspace to add the rule groups namespace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data = "data",
        .name = "name",
        .tags = "tags",
        .workspace_id = "workspaceId",
    };
};

pub const CreateRuleGroupsNamespaceOutput = struct {
    /// The Amazon Resource Name (ARN) of the new rule groups namespace.
    arn: []const u8,

    /// The name of the new rule groups namespace.
    name: []const u8,

    /// A structure that returns the current status of the rule groups namespace.
    status: ?RuleGroupsNamespaceStatus = null,

    /// The list of tag keys and values that are associated with the namespace.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .name = "name",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRuleGroupsNamespaceInput, options: CallOptions) !CreateRuleGroupsNamespaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRuleGroupsNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/rulegroupsnamespaces");
    const path = try path_buf.toOwnedSlice(allocator);

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
    try body_buf.appendSlice(allocator, "\"data\":");
    try aws.json.writeValue(@TypeOf(input.data), input.data, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRuleGroupsNamespaceOutput {
    var result: CreateRuleGroupsNamespaceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateRuleGroupsNamespaceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

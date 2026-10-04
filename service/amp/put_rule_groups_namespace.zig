const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RuleGroupsNamespaceStatus = @import("rule_groups_namespace_status.zig").RuleGroupsNamespaceStatus;

pub const PutRuleGroupsNamespaceInput = struct {
    /// A unique identifier that you can provide to ensure the idempotency of the
    /// request. Case-sensitive.
    client_token: ?[]const u8 = null,

    /// The new rules file to use in the namespace. A base64-encoded version of the
    /// YAML rule groups file.
    ///
    /// For details about the rule groups namespace structure, see
    /// [RuleGroupsNamespaceData](https://docs.aws.amazon.com/prometheus/latest/APIReference/yaml-RuleGroupsNamespaceData.html).
    data: []const u8,

    /// The name of the rule groups namespace that you are updating.
    name: []const u8,

    /// The ID of the workspace where you are updating the rule groups namespace.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data = "data",
        .name = "name",
        .workspace_id = "workspaceId",
    };
};

pub const PutRuleGroupsNamespaceOutput = struct {
    /// The ARN of the rule groups namespace.
    arn: []const u8,

    /// The name of the rule groups namespace that was updated.
    name: []const u8,

    /// A structure that includes the current status of the rule groups namespace.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRuleGroupsNamespaceInput, options: CallOptions) !PutRuleGroupsNamespaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRuleGroupsNamespaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/rulegroupsnamespaces/");
    try path_buf.appendSlice(allocator, input.name);
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

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRuleGroupsNamespaceOutput {
    const result: PutRuleGroupsNamespaceOutput = try aws.json.parseJsonObject(
        PutRuleGroupsNamespaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

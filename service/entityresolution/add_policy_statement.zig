const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StatementEffect = @import("statement_effect.zig").StatementEffect;

pub const AddPolicyStatementInput = struct {
    /// The action that the principal can use on the resource.
    ///
    /// For example, `entityresolution:GetIdMappingJob`,
    /// `entityresolution:GetMatchingJob`.
    action: []const []const u8,

    /// The Amazon Resource Name (ARN) of the resource that will be accessed by the
    /// principal.
    arn: []const u8,

    /// A set of condition keys that you can use in key policies.
    condition: ?[]const u8 = null,

    /// Determines whether the permissions specified in the policy are to be allowed
    /// (`Allow`) or denied (`Deny`).
    ///
    /// If you set the value of the `effect` parameter to `Deny` for the
    /// `AddPolicyStatement` operation, you must also set the value of the `effect`
    /// parameter in the `policy` to `Deny` for the `PutPolicy` operation.
    effect: StatementEffect,

    /// The Amazon Web Services service or Amazon Web Services account that can
    /// access the resource defined as ARN.
    principal: []const []const u8,

    /// A statement identifier that differentiates the statement from others in the
    /// same policy.
    statement_id: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .arn = "arn",
        .condition = "condition",
        .effect = "effect",
        .principal = "principal",
        .statement_id = "statementId",
    };
};

pub const AddPolicyStatementOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource that will be accessed by the
    /// principal.
    arn: []const u8,

    /// The resource-based policy.
    policy: ?[]const u8 = null,

    /// A unique identifier for the current revision of the policy.
    token: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .policy = "policy",
        .token = "token",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddPolicyStatementInput, options: CallOptions) !AddPolicyStatementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddPolicyStatementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.arn);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.statement_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"action\":");
    try aws.json.writeValue(@TypeOf(input.action), input.action, allocator, &body_buf);
    has_prev = true;
    if (input.condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"condition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"effect\":");
    try aws.json.writeValue(@TypeOf(input.effect), input.effect, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"principal\":");
    try aws.json.writeValue(@TypeOf(input.principal), input.principal, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddPolicyStatementOutput {
    const result: AddPolicyStatementOutput = try aws.json.parseJsonObject(
        AddPolicyStatementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

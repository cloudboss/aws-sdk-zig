const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Condition = @import("condition.zig").Condition;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;

pub const DetachRLSPolicyInput = struct {
    /// A Lake Formation condition, which applies to the row-level security policy
    /// attachment and contains an expression.
    condition: ?Condition = null,

    /// The name of the row-level security policy to detach.
    name: []const u8,

    /// The principal for which the row-level security policy is detached.
    principal: ?DataLakePrincipal = null,

    /// Indicates whether to remove this policy as the default row-level security
    /// policy for the resource.
    remove_default: ?bool = null,

    /// The resource from which the row-level security policy is detached.
    resource: Resource,

    pub const json_field_names = .{
        .condition = "Condition",
        .name = "Name",
        .principal = "Principal",
        .remove_default = "RemoveDefault",
        .resource = "Resource",
    };
};

pub const DetachRLSPolicyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetachRLSPolicyInput, options: CallOptions) !DetachRLSPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetachRLSPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DetachRLSPolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Condition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.principal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Principal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.remove_default) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RemoveDefault\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Resource\":");
    try aws.json.writeValue(@TypeOf(input.resource), input.resource, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetachRLSPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DetachRLSPolicyOutput = .{};

    return result;
}

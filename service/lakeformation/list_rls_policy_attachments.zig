const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataLakePrincipal = @import("data_lake_principal.zig").DataLakePrincipal;
const Resource = @import("resource.zig").Resource;
const RLSPolicyAttachment = @import("rls_policy_attachment.zig").RLSPolicyAttachment;

pub const ListRLSPolicyAttachmentsInput = struct {
    /// The maximum number of attachments to return in a single response.
    max_results: ?i32 = null,

    /// A continuation token, if this is a continuation call.
    next_token: ?[]const u8 = null,

    /// If specified, returns only the attachments for the row-level security policy
    /// with this name.
    policy_name: ?[]const u8 = null,

    /// If specified, returns only the attachments for the given principal.
    principal: ?DataLakePrincipal = null,

    /// If specified, returns only the attachments for the given resource.
    resource: ?Resource = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .policy_name = "PolicyName",
        .principal = "Principal",
        .resource = "Resource",
    };
};

pub const ListRLSPolicyAttachmentsOutput = struct {
    /// A continuation token, if not all attachments have been returned.
    next_token: ?[]const u8 = null,

    /// A list of `RLSPolicyAttachment` structures.
    rls_policy_attachments: ?[]const RLSPolicyAttachment = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .rls_policy_attachments = "RLSPolicyAttachments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListRLSPolicyAttachmentsInput, options: CallOptions) !ListRLSPolicyAttachmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListRLSPolicyAttachmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListRLSPolicyAttachments";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.principal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Principal\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Resource\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListRLSPolicyAttachmentsOutput {
    const result: ListRLSPolicyAttachmentsOutput = try aws.json.parseJsonObject(
        ListRLSPolicyAttachmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

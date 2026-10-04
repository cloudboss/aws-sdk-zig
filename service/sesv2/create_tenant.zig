const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const SendingStatus = @import("sending_status.zig").SendingStatus;

pub const CreateTenantInput = struct {
    /// An array of objects that define the tags (keys and values) to associate with
    /// the tenant
    tags: ?[]const Tag = null,

    /// The name of the tenant to create. The name can contain up to 64 alphanumeric
    /// characters, including letters, numbers, hyphens (-) and underscores (_)
    /// only.
    tenant_name: []const u8,

    pub const json_field_names = .{
        .tags = "Tags",
        .tenant_name = "TenantName",
    };
};

pub const CreateTenantOutput = struct {
    /// The date and time when the tenant was created.
    created_timestamp: ?i64 = null,

    /// The status of email sending capability for the tenant.
    sending_status: ?SendingStatus = null,

    /// An array of objects that define the tags (keys and values) associated with
    /// the tenant.
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the tenant.
    tenant_arn: ?[]const u8 = null,

    /// A unique identifier for the tenant.
    tenant_id: ?[]const u8 = null,

    /// The name of the tenant.
    tenant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .sending_status = "SendingStatus",
        .tags = "Tags",
        .tenant_arn = "TenantArn",
        .tenant_id = "TenantId",
        .tenant_name = "TenantName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTenantInput, options: CallOptions) !CreateTenantOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTenantInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/tenants";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TenantName\":");
    try aws.json.writeValue(@TypeOf(input.tenant_name), input.tenant_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTenantOutput {
    var result: CreateTenantOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateTenantOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTenantMetadata = @import("resource_tenant_metadata.zig").ResourceTenantMetadata;

pub const ListResourceTenantsInput = struct {
    /// A token returned from a previous call to `ListResourceTenants` to indicate
    /// the position in the list of resource tenants.
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to `ListResourceTenants`.
    /// If the number of results is larger than the number you specified in this
    /// parameter,
    /// then the response includes a `NextToken` element, which you can use to
    /// obtain additional results.
    page_size: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the resource to list associated tenants
    /// for.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .page_size = "PageSize",
        .resource_arn = "ResourceArn",
    };
};

pub const ListResourceTenantsOutput = struct {
    /// A token that indicates that there are additional tenants to list. To view
    /// additional tenants,
    /// issue another request to `ListResourceTenants`, and pass this token in the
    /// `NextToken` parameter.
    next_token: ?[]const u8 = null,

    /// An array that contains information about each tenant associated with the
    /// resource.
    resource_tenants: ?[]const ResourceTenantMetadata = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_tenants = "ResourceTenants",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourceTenantsInput, options: CallOptions) !ListResourceTenantsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourceTenantsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/resources/tenants/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.page_size) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PageSize\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceArn\":");
    try aws.json.writeValue(@TypeOf(input.resource_arn), input.resource_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourceTenantsOutput {
    const result: ListResourceTenantsOutput = try aws.json.parseJsonObject(
        ListResourceTenantsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

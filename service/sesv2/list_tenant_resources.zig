const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TenantResource = @import("tenant_resource.zig").TenantResource;

pub const ListTenantResourcesInput = struct {
    /// A map of filter keys and values for filtering the list of tenant resources.
    /// Currently,
    /// the only supported filter key is `RESOURCE_TYPE`.
    filter: ?[]const aws.map.StringMapEntry = null,

    /// A token returned from a previous call to `ListTenantResources` to indicate
    /// the position in the list of tenant resources.
    next_token: ?[]const u8 = null,

    /// The number of results to show in a single call to `ListTenantResources`.
    /// If the number of results is larger than the number you specified in this
    /// parameter,
    /// then the response includes a `NextToken` element, which you can use to
    /// obtain additional results.
    page_size: ?i32 = null,

    /// The name of the tenant to list resources for.
    tenant_name: []const u8,

    pub const json_field_names = .{
        .filter = "Filter",
        .next_token = "NextToken",
        .page_size = "PageSize",
        .tenant_name = "TenantName",
    };
};

pub const ListTenantResourcesOutput = struct {
    /// A token that indicates that there are additional resources to list. To view
    /// additional resources,
    /// issue another request to `ListTenantResources`, and pass this token in the
    /// `NextToken` parameter.
    next_token: ?[]const u8 = null,

    /// An array that contains information about each resource associated with the
    /// tenant.
    tenant_resources: ?[]const TenantResource = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .tenant_resources = "TenantResources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTenantResourcesInput, options: CallOptions) !ListTenantResourcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTenantResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/tenants/resources/list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTenantResourcesOutput {
    const result: ListTenantResourcesOutput = try aws.json.parseJsonObject(
        ListTenantResourcesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

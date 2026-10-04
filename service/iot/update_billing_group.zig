const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingGroupProperties = @import("billing_group_properties.zig").BillingGroupProperties;

pub const UpdateBillingGroupInput = struct {
    /// The name of the billing group.
    billing_group_name: []const u8,

    /// The properties of the billing group.
    billing_group_properties: BillingGroupProperties,

    /// The expected version of the billing group. If the version of the billing
    /// group does
    /// not match the expected version specified in the request, the
    /// `UpdateBillingGroup` request is rejected with a
    /// `VersionConflictException`.
    expected_version: ?i64 = null,

    pub const json_field_names = .{
        .billing_group_name = "billingGroupName",
        .billing_group_properties = "billingGroupProperties",
        .expected_version = "expectedVersion",
    };
};

pub const UpdateBillingGroupOutput = struct {
    /// The latest version of the billing group.
    version: ?i64 = null,

    pub const json_field_names = .{
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBillingGroupInput, options: CallOptions) !UpdateBillingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBillingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/billing-groups/");
    try path_buf.appendSlice(allocator, input.billing_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"billingGroupProperties\":");
    try aws.json.writeValue(@TypeOf(input.billing_group_properties), input.billing_group_properties, allocator, &body_buf);
    has_prev = true;
    if (input.expected_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedVersion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBillingGroupOutput {
    const result: UpdateBillingGroupOutput = try aws.json.parseJsonObject(
        UpdateBillingGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

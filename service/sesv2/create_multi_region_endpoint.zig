const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Details = @import("details.zig").Details;
const Tag = @import("tag.zig").Tag;
const Status = @import("status.zig").Status;

pub const CreateMultiRegionEndpointInput = struct {
    /// Contains details of a multi-region endpoint (global-endpoint) being created.
    details: Details,

    /// The name of the multi-region endpoint (global-endpoint).
    endpoint_name: []const u8,

    /// An array of objects that define the tags (keys and values) to associate with
    /// the multi-region endpoint (global-endpoint).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .details = "Details",
        .endpoint_name = "EndpointName",
        .tags = "Tags",
    };
};

pub const CreateMultiRegionEndpointOutput = struct {
    /// The ID of the multi-region endpoint (global-endpoint).
    endpoint_id: ?[]const u8 = null,

    /// A status of the multi-region endpoint (global-endpoint) right after the
    /// create request.
    ///
    /// * `CREATING` – The resource is being provisioned.
    ///
    /// * `READY` – The resource is ready to use.
    ///
    /// * `FAILED` – The resource failed to be provisioned.
    ///
    /// * `DELETING` – The resource is being deleted as requested.
    status: ?Status = null,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMultiRegionEndpointInput, options: CallOptions) !CreateMultiRegionEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMultiRegionEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("email", "SESv2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v2/email/multi-region-endpoints";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Details\":");
    try aws.json.writeValue(@TypeOf(input.details), input.details, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndpointName\":");
    try aws.json.writeValue(@TypeOf(input.endpoint_name), input.endpoint_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMultiRegionEndpointOutput {
    const result: CreateMultiRegionEndpointOutput = try aws.json.parseJsonObject(
        CreateMultiRegionEndpointOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

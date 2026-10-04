const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchPutProfileObjectRequestItem = @import("batch_put_profile_object_request_item.zig").BatchPutProfileObjectRequestItem;
const BatchPutProfileObjectErrorItem = @import("batch_put_profile_object_error_item.zig").BatchPutProfileObjectErrorItem;
const BatchPutProfileObjectResponseItem = @import("batch_put_profile_object_response_item.zig").BatchPutProfileObjectResponseItem;

pub const BatchPutProfileObjectInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// A list of items to add to the domain.
    items: []const BatchPutProfileObjectRequestItem,

    /// The name of the profile object type.
    object_type_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .items = "Items",
        .object_type_name = "ObjectTypeName",
    };
};

pub const BatchPutProfileObjectOutput = struct {
    /// A list of items that failed to be added to the domain.
    failed: ?[]const BatchPutProfileObjectErrorItem = null,

    /// A list of items that were successfully added to the domain.
    successful: ?[]const BatchPutProfileObjectResponseItem = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutProfileObjectInput, options: CallOptions) !BatchPutProfileObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutProfileObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/profiles/objects/batch-put-profile-object");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Items\":");
    try aws.json.writeValue(@TypeOf(input.items), input.items, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ObjectTypeName\":");
    try aws.json.writeValue(@TypeOf(input.object_type_name), input.object_type_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutProfileObjectOutput {
    const result: BatchPutProfileObjectOutput = try aws.json.parseJsonObject(
        BatchPutProfileObjectOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

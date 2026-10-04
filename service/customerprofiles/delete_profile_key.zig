const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteProfileKeyInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// A searchable identifier of a customer profile.
    key_name: []const u8,

    /// The unique identifier of a customer profile.
    profile_id: []const u8,

    /// A list of key values.
    values: []const []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .key_name = "KeyName",
        .profile_id = "ProfileId",
        .values = "Values",
    };
};

pub const DeleteProfileKeyOutput = struct {
    /// A message that indicates the delete request is done.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteProfileKeyInput, options: CallOptions) !DeleteProfileKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteProfileKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/profiles/keys/delete");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyName\":");
    try aws.json.writeValue(@TypeOf(input.key_name), input.key_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProfileId\":");
    try aws.json.writeValue(@TypeOf(input.profile_id), input.profile_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Values\":");
    try aws.json.writeValue(@TypeOf(input.values), input.values, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteProfileKeyOutput {
    var result: DeleteProfileKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteProfileKeyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

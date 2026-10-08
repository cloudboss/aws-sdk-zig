const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteBrandProfileInput = struct {
    /// The unique identifier of the brand profile. You can specify either the bare
    /// ID or the full Amazon Resource Name (ARN).
    brand_profile_id: []const u8,

    pub const json_field_names = .{
        .brand_profile_id = "brandProfileId",
    };
};

pub const DeleteBrandProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the brand profile.
    brand_profile_arn: []const u8,

    /// The unique identifier of the brand profile.
    brand_profile_id: []const u8,

    pub const json_field_names = .{
        .brand_profile_arn = "brandProfileArn",
        .brand_profile_id = "brandProfileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBrandProfileInput, options: CallOptions) !DeleteBrandProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBrandProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brand-profiles/");
    try path_buf.appendSlice(allocator, input.brand_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBrandProfileOutput {
    const result: DeleteBrandProfileOutput = try aws.json.parseJsonObject(
        DeleteBrandProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

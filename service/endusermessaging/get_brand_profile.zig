const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Status = @import("status.zig").Status;

pub const GetBrandProfileInput = struct {
    /// The unique identifier of the brand profile. You can specify either the bare
    /// ID or the full Amazon Resource Name (ARN).
    brand_profile_id: []const u8,

    pub const json_field_names = .{
        .brand_profile_id = "brandProfileId",
    };
};

pub const GetBrandProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the brand profile.
    brand_profile_arn: []const u8,

    /// The unique identifier of the brand profile.
    brand_profile_id: []const u8,

    /// The name of the brand profile. The name can contain alphanumeric characters,
    /// underscores, hyphens, and spaces.
    brand_profile_name: []const u8,

    /// The time when the resource was created, in Unix epoch time.
    created_at: i64,

    /// Specifies whether deletion protection is enabled. When enabled, the resource
    /// cannot be deleted until deletion protection is turned off.
    deletion_protection_enabled: bool,

    /// The current lifecycle status of the brand profile.
    status: Status,

    /// The time when the resource was last updated, in Unix epoch time.
    updated_at: i64,

    pub const json_field_names = .{
        .brand_profile_arn = "brandProfileArn",
        .brand_profile_id = "brandProfileId",
        .brand_profile_name = "brandProfileName",
        .created_at = "createdAt",
        .deletion_protection_enabled = "deletionProtectionEnabled",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBrandProfileInput, options: CallOptions) !GetBrandProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBrandProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brand-profiles/");
    try path_buf.appendSlice(allocator, input.brand_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBrandProfileOutput {
    const result: GetBrandProfileOutput = try aws.json.parseJsonObject(
        GetBrandProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

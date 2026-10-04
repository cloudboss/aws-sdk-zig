const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetManagedNotificationConfigurationInput = struct {
    /// The Amazon Resource Name (ARN) of the `ManagedNotificationConfiguration` to
    /// return.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const GetManagedNotificationConfigurationOutput = struct {
    /// The ARN of the `ManagedNotificationConfiguration` resource.
    arn: []const u8,

    /// The category of the `ManagedNotificationConfiguration`.
    category: []const u8,

    /// The description of the `ManagedNotificationConfiguration`.
    description: []const u8,

    /// The name of the `ManagedNotificationConfiguration`.
    name: []const u8,

    /// The subCategory of the `ManagedNotificationConfiguration`.
    sub_category: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .category = "category",
        .description = "description",
        .name = "name",
        .sub_category = "subCategory",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedNotificationConfigurationInput, options: CallOptions) !GetManagedNotificationConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "notifications", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedNotificationConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("notifications", "Notifications", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-notification-configurations/");
    try path_buf.appendSlice(allocator, input.arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedNotificationConfigurationOutput {
    const result: GetManagedNotificationConfigurationOutput = try aws.json.parseJsonObject(
        GetManagedNotificationConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

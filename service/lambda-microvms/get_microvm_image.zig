const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MicrovmImageState = @import("microvm_image_state.zig").MicrovmImageState;

pub const GetMicrovmImageInput = struct {
    /// The unique identifier (ARN or ID) of the MicroVM image to retrieve.
    image_identifier: []const u8,

    pub const json_field_names = .{
        .image_identifier = "imageIdentifier",
    };
};

pub const GetMicrovmImageOutput = struct {
    /// The timestamp when the MicroVM image was created.
    created_at: i64,

    /// The ARN of the MicroVM image.
    image_arn: []const u8,

    /// The latest active version of the MicroVM image.
    latest_active_image_version: ?[]const u8 = null,

    /// The latest failed version of the MicroVM image, if any.
    latest_failed_image_version: ?[]const u8 = null,

    /// The name of the MicroVM image.
    name: []const u8,

    /// The current state of the MicroVM image.
    state: MicrovmImageState,

    /// A set of key-value pairs that you can attach to the resource. Use tags to
    /// categorize resources for cost allocation, access control (ABAC), and
    /// organization.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the MicroVM image was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .image_arn = "imageArn",
        .latest_active_image_version = "latestActiveImageVersion",
        .latest_failed_image_version = "latestFailedImageVersion",
        .name = "name",
        .state = "state",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMicrovmImageInput, options: CallOptions) !GetMicrovmImageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMicrovmImageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvm-images/");
    try path_buf.appendSlice(allocator, input.image_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMicrovmImageOutput {
    const result: GetMicrovmImageOutput = try aws.json.parseJsonObject(
        GetMicrovmImageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

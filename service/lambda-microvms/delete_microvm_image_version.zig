const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MicrovmImageVersionState = @import("microvm_image_version_state.zig").MicrovmImageVersionState;

pub const DeleteMicrovmImageVersionInput = struct {
    /// The unique identifier (ARN or ID) of the MicroVM image.
    image_identifier: []const u8,

    /// The version of the MicroVM image to delete.
    image_version: []const u8,

    pub const json_field_names = .{
        .image_identifier = "imageIdentifier",
        .image_version = "imageVersion",
    };
};

pub const DeleteMicrovmImageVersionOutput = struct {
    /// The identifier of the MicroVM image.
    image_identifier: []const u8,

    /// The version that was deleted.
    image_version: []const u8,

    /// The current state of the MicroVM image version after deletion.
    state: MicrovmImageVersionState,

    pub const json_field_names = .{
        .image_identifier = "imageIdentifier",
        .image_version = "imageVersion",
        .state = "state",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteMicrovmImageVersionInput, options: CallOptions) !DeleteMicrovmImageVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteMicrovmImageVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda Microvms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-09-09/microvm-images/");
    try path_buf.appendSlice(allocator, input.image_identifier);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.image_version);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteMicrovmImageVersionOutput {
    const result: DeleteMicrovmImageVersionOutput = try aws.json.parseJsonObject(
        DeleteMicrovmImageVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

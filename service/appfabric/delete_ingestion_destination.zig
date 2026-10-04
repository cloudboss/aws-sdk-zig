const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteIngestionDestinationInput = struct {
    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// app bundle
    /// to use for the request.
    app_bundle_identifier: []const u8,

    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// ingestion
    /// destination to use for the request.
    ingestion_destination_identifier: []const u8,

    /// The Amazon Resource Name (ARN) or Universal Unique Identifier (UUID) of the
    /// ingestion to
    /// use for the request.
    ingestion_identifier: []const u8,

    pub const json_field_names = .{
        .app_bundle_identifier = "appBundleIdentifier",
        .ingestion_destination_identifier = "ingestionDestinationIdentifier",
        .ingestion_identifier = "ingestionIdentifier",
    };
};

pub const DeleteIngestionDestinationOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteIngestionDestinationInput, options: CallOptions) !DeleteIngestionDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appfabric", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteIngestionDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appfabric", "AppFabric", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/appbundles/");
    try path_buf.appendSlice(allocator, input.app_bundle_identifier);
    try path_buf.appendSlice(allocator, "/ingestions/");
    try path_buf.appendSlice(allocator, input.ingestion_identifier);
    try path_buf.appendSlice(allocator, "/ingestiondestinations/");
    try path_buf.appendSlice(allocator, input.ingestion_destination_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteIngestionDestinationOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteIngestionDestinationOutput = .{};

    return result;
}

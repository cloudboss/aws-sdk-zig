const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CancelTrainedModelInput = struct {
    /// The membership ID of the trained model job that you want to cancel.
    membership_identifier: []const u8,

    /// The Amazon Resource Name (ARN) of the trained model job that you want to
    /// cancel.
    trained_model_arn: []const u8,

    /// The version identifier of the trained model to cancel. This parameter allows
    /// you to specify which version of the trained model you want to cancel when
    /// multiple versions exist.
    ///
    /// If `versionIdentifier` is not specified, the base model will be cancelled.
    version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .trained_model_arn = "trainedModelArn",
        .version_identifier = "versionIdentifier",
    };
};

pub const CancelTrainedModelOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelTrainedModelInput, options: CallOptions) !CancelTrainedModelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelTrainedModelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-models/");
    try path_buf.appendSlice(allocator, input.trained_model_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.version_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "versionIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelTrainedModelOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CancelTrainedModelOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CompleteAttachedFileUploadInput = struct {
    /// The resource to which the attached file is (being) uploaded to. The
    /// supported resources are
    /// [Cases](https://docs.aws.amazon.com/connect/latest/adminguide/cases.html),
    /// [Email](https://docs.aws.amazon.com/connect/latest/adminguide/setup-email-channel.html), and [Task](https://docs.aws.amazon.com/connect/latest/adminguide/concepts-getting-started-tasks.html).
    ///
    /// This value must be a valid ARN.
    associated_resource_arn: []const u8,

    /// The unique identifier of the attached file resource.
    file_id: []const u8,

    /// The unique identifier of the Connect Customer instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .associated_resource_arn = "AssociatedResourceArn",
        .file_id = "FileId",
        .instance_id = "InstanceId",
    };
};

pub const CompleteAttachedFileUploadOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompleteAttachedFileUploadInput, options: CallOptions) !CompleteAttachedFileUploadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CompleteAttachedFileUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/attached-files/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.file_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "associatedResourceArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.associated_resource_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompleteAttachedFileUploadOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CompleteAttachedFileUploadOutput = .{};

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageLensTag = @import("storage_lens_tag.zig").StorageLensTag;
const serde = @import("serde.zig");

pub const PutStorageLensConfigurationTaggingInput = struct {
    /// The account ID of the requester.
    account_id: []const u8,

    /// The ID of the S3 Storage Lens configuration.
    config_id: []const u8,

    /// The tag set of the S3 Storage Lens configuration.
    ///
    /// You can set up to a maximum of 50 tags.
    tags: []const StorageLensTag,
};

pub const PutStorageLensConfigurationTaggingOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutStorageLensConfigurationTaggingInput, options: CallOptions) !PutStorageLensConfigurationTaggingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutStorageLensConfigurationTaggingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v20180820/storagelens/");
    try path_buf.appendSlice(allocator, input.config_id);
    try path_buf.appendSlice(allocator, "/tagging");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<PutStorageLensConfigurationTaggingRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<Tags>");
    try serde.serializeStorageLensTags(allocator, &body_buf, input.tags, "Tag");
    try body_buf.appendSlice(allocator, "</Tags>");
    try body_buf.appendSlice(allocator, "</PutStorageLensConfigurationTaggingRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutStorageLensConfigurationTaggingOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutStorageLensConfigurationTaggingOutput = .{};

    return result;
}

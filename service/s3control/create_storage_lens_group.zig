const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StorageLensGroup = @import("storage_lens_group.zig").StorageLensGroup;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const CreateStorageLensGroupInput = struct {
    /// The Amazon Web Services account ID that the Storage Lens group is created
    /// from and associated with.
    account_id: []const u8,

    /// The Storage Lens group configuration.
    storage_lens_group: StorageLensGroup,

    /// The Amazon Web Services resource tags that you're adding to your Storage
    /// Lens group. This parameter is optional.
    tags: ?[]const Tag = null,
};

pub const CreateStorageLensGroupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStorageLensGroupInput, options: CallOptions) !CreateStorageLensGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStorageLensGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/storagelensgroup";

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CreateStorageLensGroupRequest xmlns=\"http://awss3control.amazonaws.com/doc/2018-08-20/\">");
    try body_buf.appendSlice(allocator, "<StorageLensGroup>");
    try serde.serializeStorageLensGroup(allocator, &body_buf, input.storage_lens_group);
    try body_buf.appendSlice(allocator, "</StorageLensGroup>");
    if (input.tags) |v| {
        try body_buf.appendSlice(allocator, "<Tags>");
        try serde.serializeTagList(allocator, &body_buf, v, "Tag");
        try body_buf.appendSlice(allocator, "</Tags>");
    }
    try body_buf.appendSlice(allocator, "</CreateStorageLensGroupRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStorageLensGroupOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: CreateStorageLensGroupOutput = .{};

    return result;
}

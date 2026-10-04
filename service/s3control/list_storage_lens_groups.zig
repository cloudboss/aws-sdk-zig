const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListStorageLensGroupEntry = @import("list_storage_lens_group_entry.zig").ListStorageLensGroupEntry;
const serde = @import("serde.zig");

pub const ListStorageLensGroupsInput = struct {
    /// The Amazon Web Services account ID that owns the Storage Lens groups.
    account_id: []const u8,

    /// The token for the next set of results, or `null` if there are no more
    /// results.
    next_token: ?[]const u8 = null,
};

pub const ListStorageLensGroupsOutput = struct {
    /// If `NextToken` is returned, there are more Storage Lens groups results
    /// available. The value of `NextToken` is a
    /// unique pagination token for each page. Make the call again using the
    /// returned token to
    /// retrieve the next page. Keep all other arguments unchanged. Each pagination
    /// token expires
    /// after 24 hours.
    next_token: ?[]const u8 = null,

    /// The list of Storage Lens groups that exist in the specified home Region.
    storage_lens_group_list: ?[]const ListStorageLensGroupEntry = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStorageLensGroupsInput, options: CallOptions) !ListStorageLensGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStorageLensGroupsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3-control", "S3 Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v20180820/storagelensgroup";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "x-amz-account-id", input.account_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStorageLensGroupsOutput {
    var result: ListStorageLensGroupsOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var storage_lens_group_list_list: std.ArrayList(ListStorageLensGroupEntry) = .empty;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StorageLensGroup")) {
                    try storage_lens_group_list_list.append(allocator, try serde.deserializeListStorageLensGroupEntry(allocator, &reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.storage_lens_group_list = if (storage_lens_group_list_list.items.len > 0) try storage_lens_group_list_list.toOwnedSlice(allocator) else null;
    _ = headers;

    return result;
}

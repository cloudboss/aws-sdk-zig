const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListMountTargetsDescription = @import("list_mount_targets_description.zig").ListMountTargetsDescription;

pub const ListMountTargetsInput = struct {
    /// Optional filter to list only mount targets associated with the specified
    /// access point ID or Amazon Resource Name (ARN).
    access_point_id: ?[]const u8 = null,

    /// Optional filter to list only mount targets associated with the specified S3
    /// File System ID or Amazon Resource Name (ARN). If provided, only mount
    /// targets for this file system will be returned in the response.
    file_system_id: ?[]const u8 = null,

    /// The maximum number of mount targets to return in a single response.
    max_results: ?i32 = null,

    /// A pagination token returned from a previous call to continue listing mount
    /// targets.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_id = "accessPointId",
        .file_system_id = "fileSystemId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListMountTargetsOutput = struct {
    /// An array of mount target descriptions.
    mount_targets: ?[]const ListMountTargetsDescription = null,

    /// A pagination token to use in a subsequent request if more results are
    /// available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .mount_targets = "mountTargets",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMountTargetsInput, options: CallOptions) !ListMountTargetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMountTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/mount-targets";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.access_point_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "accessPointId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.file_system_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "fileSystemId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMountTargetsOutput {
    const result: ListMountTargetsOutput = try aws.json.parseJsonObject(
        ListMountTargetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

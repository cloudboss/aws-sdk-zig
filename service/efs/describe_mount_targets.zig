const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MountTargetDescription = @import("mount_target_description.zig").MountTargetDescription;

pub const DescribeMountTargetsInput = struct {
    /// (Optional) The ID of the access point whose mount targets that you want to
    /// list. It must be included in your request if a
    /// `FileSystemId` or `MountTargetId` is not included in your request. Accepts
    /// either an access point ID or ARN as input.
    access_point_id: ?[]const u8 = null,

    /// (Optional) ID of the file system whose mount targets you want to list
    /// (String). It must
    /// be included in your request if an `AccessPointId` or `MountTargetId` is not
    /// included. Accepts either a file system ID or ARN as input.
    file_system_id: ?[]const u8 = null,

    /// (Optional) Opaque pagination token returned from a previous
    /// `DescribeMountTargets` operation (String). If present, it specifies to
    /// continue
    /// the list from where the previous returning call left off.
    marker: ?[]const u8 = null,

    /// (Optional) Maximum number of mount targets to return in the response.
    /// Currently, this
    /// number is automatically set to
    /// 10, and other values are ignored. The response is paginated at 100 per page
    /// if you have more than 100 mount targets.
    max_items: ?i32 = null,

    /// (Optional) ID of the mount target that you want to have described (String).
    /// It must be
    /// included in your request if `FileSystemId` is not included. Accepts either a
    /// mount target ID or ARN as input.
    mount_target_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_point_id = "AccessPointId",
        .file_system_id = "FileSystemId",
        .marker = "Marker",
        .max_items = "MaxItems",
        .mount_target_id = "MountTargetId",
    };
};

pub const DescribeMountTargetsOutput = struct {
    /// If the request included the `Marker`, the response returns that value in
    /// this field.
    marker: ?[]const u8 = null,

    /// Returns the file system's mount targets as an array of
    /// `MountTargetDescription` objects.
    mount_targets: ?[]const MountTargetDescription = null,

    /// If a value is present, there are more mount targets to return. In a
    /// subsequent request,
    /// you can provide `Marker` in your request with this value to retrieve the
    /// next set
    /// of mount targets.
    next_marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .marker = "Marker",
        .mount_targets = "MountTargets",
        .next_marker = "NextMarker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMountTargetsInput, options: CallOptions) !DescribeMountTargetsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticfilesystem", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMountTargetsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticfilesystem", "EFS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-02-01/mount-targets";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.access_point_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "AccessPointId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.file_system_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "FileSystemId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.mount_target_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MountTargetId=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMountTargetsOutput {
    const result: DescribeMountTargetsOutput = try aws.json.parseJsonObject(
        DescribeMountTargetsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

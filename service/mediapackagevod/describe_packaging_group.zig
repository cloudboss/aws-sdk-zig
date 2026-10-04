const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Authorization = @import("authorization.zig").Authorization;
const EgressAccessLogs = @import("egress_access_logs.zig").EgressAccessLogs;

pub const DescribePackagingGroupInput = struct {
    /// The ID of a MediaPackage VOD PackagingGroup resource.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const DescribePackagingGroupOutput = struct {
    /// The approximate asset count of the PackagingGroup.
    approximate_asset_count: ?i32 = null,

    /// The ARN of the PackagingGroup.
    arn: ?[]const u8 = null,

    authorization: ?Authorization = null,

    /// The time the PackagingGroup was created.
    created_at: ?[]const u8 = null,

    /// The fully qualified domain name for Assets in the PackagingGroup.
    domain_name: ?[]const u8 = null,

    egress_access_logs: ?EgressAccessLogs = null,

    /// The ID of the PackagingGroup.
    id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .approximate_asset_count = "ApproximateAssetCount",
        .arn = "Arn",
        .authorization = "Authorization",
        .created_at = "CreatedAt",
        .domain_name = "DomainName",
        .egress_access_logs = "EgressAccessLogs",
        .id = "Id",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePackagingGroupInput, options: CallOptions) !DescribePackagingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackage-vod", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePackagingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage-vod", "MediaPackage Vod", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packaging_groups/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePackagingGroupOutput {
    var result: DescribePackagingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribePackagingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

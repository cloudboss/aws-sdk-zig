const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CmafPackage = @import("cmaf_package.zig").CmafPackage;
const DashPackage = @import("dash_package.zig").DashPackage;
const HlsPackage = @import("hls_package.zig").HlsPackage;
const MssPackage = @import("mss_package.zig").MssPackage;

pub const DescribePackagingConfigurationInput = struct {
    /// The ID of a MediaPackage VOD PackagingConfiguration resource.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const DescribePackagingConfigurationOutput = struct {
    /// The ARN of the PackagingConfiguration.
    arn: ?[]const u8 = null,

    cmaf_package: ?CmafPackage = null,

    /// The time the PackagingConfiguration was created.
    created_at: ?[]const u8 = null,

    dash_package: ?DashPackage = null,

    hls_package: ?HlsPackage = null,

    /// The ID of the PackagingConfiguration.
    id: ?[]const u8 = null,

    mss_package: ?MssPackage = null,

    /// The ID of a PackagingGroup.
    packaging_group_id: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .cmaf_package = "CmafPackage",
        .created_at = "CreatedAt",
        .dash_package = "DashPackage",
        .hls_package = "HlsPackage",
        .id = "Id",
        .mss_package = "MssPackage",
        .packaging_group_id = "PackagingGroupId",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePackagingConfigurationInput, options: CallOptions) !DescribePackagingConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePackagingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage-vod", "MediaPackage Vod", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/packaging_configurations/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePackagingConfigurationOutput {
    const result: DescribePackagingConfigurationOutput = try aws.json.parseJsonObject(
        DescribePackagingConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

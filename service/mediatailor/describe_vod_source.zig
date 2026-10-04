const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdBreakOpportunity = @import("ad_break_opportunity.zig").AdBreakOpportunity;
const HttpPackageConfiguration = @import("http_package_configuration.zig").HttpPackageConfiguration;

pub const DescribeVodSourceInput = struct {
    /// The name of the source location associated with this VOD Source.
    source_location_name: []const u8,

    /// The name of the VOD Source.
    vod_source_name: []const u8,

    pub const json_field_names = .{
        .source_location_name = "SourceLocationName",
        .vod_source_name = "VodSourceName",
    };
};

pub const DescribeVodSourceOutput = struct {
    /// The ad break opportunities within the VOD source.
    ad_break_opportunities: ?[]const AdBreakOpportunity = null,

    /// The ARN of the VOD source.
    arn: ?[]const u8 = null,

    /// The timestamp that indicates when the VOD source was created.
    creation_time: ?i64 = null,

    /// The HTTP package configurations.
    http_package_configurations: ?[]const HttpPackageConfiguration = null,

    /// The last modified time of the VOD source.
    last_modified_time: ?i64 = null,

    /// The name of the source location associated with the VOD source.
    source_location_name: ?[]const u8 = null,

    /// The tags assigned to the VOD source. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The name of the VOD source.
    vod_source_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .ad_break_opportunities = "AdBreakOpportunities",
        .arn = "Arn",
        .creation_time = "CreationTime",
        .http_package_configurations = "HttpPackageConfigurations",
        .last_modified_time = "LastModifiedTime",
        .source_location_name = "SourceLocationName",
        .tags = "Tags",
        .vod_source_name = "VodSourceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVodSourceInput, options: CallOptions) !DescribeVodSourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediatailor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVodSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sourceLocation/");
    try path_buf.appendSlice(allocator, input.source_location_name);
    try path_buf.appendSlice(allocator, "/vodSource/");
    try path_buf.appendSlice(allocator, input.vod_source_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVodSourceOutput {
    const result: DescribeVodSourceOutput = try aws.json.parseJsonObject(
        DescribeVodSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

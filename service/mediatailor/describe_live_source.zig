const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HttpPackageConfiguration = @import("http_package_configuration.zig").HttpPackageConfiguration;

pub const DescribeLiveSourceInput = struct {
    /// The name of the live source.
    live_source_name: []const u8,

    /// The name of the source location associated with this Live Source.
    source_location_name: []const u8,

    pub const json_field_names = .{
        .live_source_name = "LiveSourceName",
        .source_location_name = "SourceLocationName",
    };
};

pub const DescribeLiveSourceOutput = struct {
    /// The ARN of the live source.
    arn: ?[]const u8 = null,

    /// The timestamp that indicates when the live source was created.
    creation_time: ?i64 = null,

    /// The HTTP package configurations.
    http_package_configurations: ?[]const HttpPackageConfiguration = null,

    /// The timestamp that indicates when the live source was modified.
    last_modified_time: ?i64 = null,

    /// The name of the live source.
    live_source_name: ?[]const u8 = null,

    /// The name of the source location associated with the live source.
    source_location_name: ?[]const u8 = null,

    /// The tags assigned to the live source. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .http_package_configurations = "HttpPackageConfigurations",
        .last_modified_time = "LastModifiedTime",
        .live_source_name = "LiveSourceName",
        .source_location_name = "SourceLocationName",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLiveSourceInput, options: CallOptions) !DescribeLiveSourceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLiveSourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/sourceLocation/");
    try path_buf.appendSlice(allocator, input.source_location_name);
    try path_buf.appendSlice(allocator, "/liveSource/");
    try path_buf.appendSlice(allocator, input.live_source_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLiveSourceOutput {
    const result: DescribeLiveSourceOutput = try aws.json.parseJsonObject(
        DescribeLiveSourceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentPlatform = @import("component_platform.zig").ComponentPlatform;
const CloudComponentStatus = @import("cloud_component_status.zig").CloudComponentStatus;

pub const DescribeComponentInput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
    };
};

pub const DescribeComponentOutput = struct {
    /// The
    /// [ARN](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the component version.
    arn: ?[]const u8 = null,

    /// The name of the component.
    component_name: ?[]const u8 = null,

    /// The version of the component.
    component_version: ?[]const u8 = null,

    /// The time at which the component was created, expressed in ISO 8601 format.
    creation_timestamp: ?i64 = null,

    /// The description of the component version.
    description: ?[]const u8 = null,

    /// The platforms that the component version supports.
    platforms: ?[]const ComponentPlatform = null,

    /// The publisher of the component version.
    publisher: ?[]const u8 = null,

    /// The status of the component version in IoT Greengrass V2. This status
    /// is different from the status of the component on a core device.
    status: ?CloudComponentStatus = null,

    /// A list of key-value pairs that contain metadata for the resource. For more
    /// information, see [Tag your
    /// resources](https://docs.aws.amazon.com/greengrass/v2/developerguide/tag-resources.html) in the *IoT Greengrass V2 Developer Guide*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .component_name = "componentName",
        .component_version = "componentVersion",
        .creation_timestamp = "creationTimestamp",
        .description = "description",
        .platforms = "platforms",
        .publisher = "publisher",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeComponentInput, options: CallOptions) !DescribeComponentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "greengrass", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("greengrass", "GreengrassV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/greengrass/v2/components/");
    try path_buf.appendSlice(allocator, input.arn);
    try path_buf.appendSlice(allocator, "/metadata");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeComponentOutput {
    var result: DescribeComponentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeComponentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

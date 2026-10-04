const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetCloudWatchAlarmTemplateGroupInput = struct {
    /// A cloudwatch alarm template group's identifier. Can be either be its id or
    /// current name.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetCloudWatchAlarmTemplateGroupOutput = struct {
    /// A cloudwatch alarm template group's ARN (Amazon Resource Name)
    arn: ?[]const u8 = null,

    created_at: ?i64 = null,

    /// A resource's optional description.
    description: ?[]const u8 = null,

    /// A cloudwatch alarm template group's id. AWS provided template groups have
    /// ids that start with `aws-`
    id: ?[]const u8 = null,

    modified_at: ?i64 = null,

    /// A resource's name. Names must be unique within the scope of a resource type
    /// in a specific region.
    name: ?[]const u8 = null,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .description = "Description",
        .id = "Id",
        .modified_at = "ModifiedAt",
        .name = "Name",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCloudWatchAlarmTemplateGroupInput, options: CallOptions) !GetCloudWatchAlarmTemplateGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCloudWatchAlarmTemplateGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/cloudwatch-alarm-template-groups/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCloudWatchAlarmTemplateGroupOutput {
    var result: GetCloudWatchAlarmTemplateGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCloudWatchAlarmTemplateGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeedAssociation = @import("feed_association.zig").FeedAssociation;
const GetOutput = @import("get_output.zig").GetOutput;
const FeedStatus = @import("feed_status.zig").FeedStatus;

pub const GetFeedInput = struct {
    /// The ID of the feed to query.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetFeedOutput = struct {
    /// The Amazon Resource Name (ARN) of an AWS Identity and Access Management
    /// (IAM) role that Elemental Inference assumes. Elemental Inference uses this
    /// role to access resources in your account on your behalf. This property is
    /// absent if the feed doesn't have an IAM role.
    access_role_arn: ?[]const u8 = null,

    /// The ARN of the feed.
    arn: []const u8,

    /// Information about the resource that is associated with the feed. It's
    /// possible that there is no associated resource. This is not an error.
    association: ?FeedAssociation = null,

    /// The dataEndpoints of the feed.
    data_endpoints: ?[]const []const u8 = null,

    /// The ID of the feed.
    id: []const u8,

    /// The name of the feed.
    name: []const u8,

    /// An array of the outputs in the feed.
    outputs: ?[]const GetOutput = null,

    /// The status of the feed.
    status: FeedStatus,

    /// A list of the tags, if any, for the feed.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_role_arn = "accessRoleArn",
        .arn = "arn",
        .association = "association",
        .data_endpoints = "dataEndpoints",
        .id = "id",
        .name = "name",
        .outputs = "outputs",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFeedInput, options: CallOptions) !GetFeedOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elemental-inference", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFeedInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/feed/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFeedOutput {
    const result: GetFeedOutput = try aws.json.parseJsonObject(
        GetFeedOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateOutput = @import("update_output.zig").UpdateOutput;
const FeedAssociation = @import("feed_association.zig").FeedAssociation;
const GetOutput = @import("get_output.zig").GetOutput;
const FeedStatus = @import("feed_status.zig").FeedStatus;

pub const UpdateFeedInput = struct {
    /// The ARN of an IAM role that Elemental Inference assumes to access resources
    /// in your account on your behalf. You can specify the existing role (to leave
    /// it unchanged) or a new role. You specify one access role for each feed.
    access_role_arn: ?[]const u8 = null,

    /// The ID of the feed to update.
    id: []const u8,

    /// Required. You can specify the existing name (to leave it unchanged) or a new
    /// name.
    name: []const u8,

    /// Required. You can specify the existing array of outputs (to leave outputs
    /// unchanged) or you can specify a new array.
    outputs: []const UpdateOutput,

    pub const json_field_names = .{
        .access_role_arn = "accessRoleArn",
        .id = "id",
        .name = "name",
        .outputs = "outputs",
    };
};

pub const UpdateFeedOutput = struct {
    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role for the feed, after the update. This property is absent if the
    /// feed doesn't have an IAM role.
    access_role_arn: ?[]const u8 = null,

    /// The ARN of the feed.
    arn: []const u8,

    /// Information about the resource that is associated with the feed, if any.
    association: ?FeedAssociation = null,

    /// The data endpoints of the feed.
    data_endpoints: ?[]const []const u8 = null,

    /// The ID of the feed.
    id: []const u8,

    /// The updated or original name of the feed.
    name: []const u8,

    /// The array of outputs in the feed. You might have left this array unchanged,
    /// or you might have changed it.
    outputs: ?[]const GetOutput = null,

    /// The status of the feed.
    status: FeedStatus,

    /// The tags associated with the feed.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFeedInput, options: CallOptions) !UpdateFeedOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFeedInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/feed/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.access_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"accessRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputs\":");
    try aws.json.writeValue(@TypeOf(input.outputs), input.outputs, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFeedOutput {
    const result: UpdateFeedOutput = try aws.json.parseJsonObject(
        UpdateFeedOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

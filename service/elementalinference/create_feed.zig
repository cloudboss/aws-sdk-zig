const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateOutput = @import("create_output.zig").CreateOutput;
const FeedAssociation = @import("feed_association.zig").FeedAssociation;
const GetOutput = @import("get_output.zig").GetOutput;
const FeedStatus = @import("feed_status.zig").FeedStatus;

pub const CreateFeedInput = struct {
    /// The ARN of an IAM role that Elemental Inference assumes to access resources
    /// in your account on your behalf. For example, the smart crop feature uses
    /// this role to read graphics-compositing templates from your Amazon S3 bucket.
    /// You specify one access role for each feed.
    access_role_arn: ?[]const u8 = null,

    /// A user-friendly name for this feed.
    name: []const u8,

    /// An array of outputs for this feed. Each output represents a specific
    /// Elemental Inference feature. For example, there is one output type for the
    /// smart crop feature. You must specify at least one output, but you can later
    /// add outputs using AssociateFeed, or add, modify, and delete outputs using
    /// UpdateFeed.
    outputs: []const CreateOutput,

    /// Optional tags. You can also add tags later, using TagResource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .access_role_arn = "accessRoleArn",
        .name = "name",
        .outputs = "outputs",
        .tags = "tags",
    };
};

pub const CreateFeedOutput = struct {
    /// The Amazon Resource Name (ARN) of the AWS Identity and Access Management
    /// (IAM) role that you specified in the request. This property is absent if you
    /// didn't specify an IAM role.
    access_role_arn: ?[]const u8 = null,

    /// A unique ARN that Elemental Inference assigns to the feed.
    arn: []const u8,

    /// The association for this feed. When you create the feed, this property is
    /// empty. You must associate a resource with the feed using AssociateFeed or
    /// UpdateFeed.
    association: ?FeedAssociation = null,

    /// An array of endpoints for the feed. Typically, there is only one endpoint.
    /// The feed receives source media at this endpoint (when the calling
    /// application calls PutMedia) and returns the resulting metadata to this
    /// endpoint (when the calling application calls GetMetadata).
    data_endpoints: ?[]const []const u8 = null,

    /// A unique ID that Elemental Inference assigns to the feed.
    id: []const u8,

    /// The name that you specified in the request.
    name: []const u8,

    /// Repeats the outputs that you specified in the request.
    outputs: ?[]const GetOutput = null,

    /// The current status of the feed. After creation of the feed has succeeded,
    /// the status will be AVAILABLE.
    status: FeedStatus,

    /// Any tags that you included when you created the feed.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFeedInput, options: CallOptions) !CreateFeedOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFeedInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/feed";

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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFeedOutput {
    const result: CreateFeedOutput = try aws.json.parseJsonObject(
        CreateFeedOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

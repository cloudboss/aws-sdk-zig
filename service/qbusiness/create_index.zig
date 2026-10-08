const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexCapacityConfiguration = @import("index_capacity_configuration.zig").IndexCapacityConfiguration;
const Tag = @import("tag.zig").Tag;
const IndexType = @import("index_type.zig").IndexType;

pub const CreateIndexInput = struct {
    /// The identifier of the Amazon Q Business application using the index.
    application_id: []const u8,

    /// The capacity units you want to provision for your index. You can add and
    /// remove capacity to fit your usage needs.
    capacity_configuration: ?IndexCapacityConfiguration = null,

    /// A token that you provide to identify the request to create an index.
    /// Multiple calls to the `CreateIndex` API with the same client token will
    /// create only one index.
    client_token: ?[]const u8 = null,

    /// A description for the Amazon Q Business index.
    description: ?[]const u8 = null,

    /// A name for the Amazon Q Business index.
    display_name: []const u8,

    /// A list of key-value pairs that identify or categorize the index. You can
    /// also use tags to help control access to the index. Tag keys and values can
    /// consist of Unicode letters, digits, white space, and any of the following
    /// symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    /// The index type that's suitable for your needs. For more information on
    /// what's included in each type of index, see [Amazon Q Business
    /// tiers](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/tiers.html#index-tiers).
    type: ?IndexType = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .capacity_configuration = "capacityConfiguration",
        .client_token = "clientToken",
        .description = "description",
        .display_name = "displayName",
        .tags = "tags",
        .type = "type",
    };
};

pub const CreateIndexOutput = struct {
    /// The Amazon Resource Name (ARN) of an Amazon Q Business index.
    index_arn: ?[]const u8 = null,

    /// The identifier for the Amazon Q Business index.
    index_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .index_arn = "indexArn",
        .index_id = "indexId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIndexInput, options: CallOptions) !CreateIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capacity_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capacityConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"displayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"type\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIndexOutput {
    const result: CreateIndexOutput = try aws.json.parseJsonObject(
        CreateIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

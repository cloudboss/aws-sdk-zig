const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllowListCriteria = @import("allow_list_criteria.zig").AllowListCriteria;

pub const CreateAllowListInput = struct {
    /// A unique, case-sensitive token that you provide to ensure the idempotency of
    /// the request.
    client_token: []const u8,

    /// The criteria that specify the text or text pattern to ignore. The criteria
    /// can be the location and name of an S3 object that lists specific text to
    /// ignore (s3WordsList), or a regular expression (regex) that defines a text
    /// pattern to ignore.
    criteria: AllowListCriteria,

    /// A custom description of the allow list. The description can contain as many
    /// as 512 characters.
    description: ?[]const u8 = null,

    /// A custom name for the allow list. The name can contain as many as 128
    /// characters.
    name: []const u8,

    /// A map of key-value pairs that specifies the tags to associate with the allow
    /// list.
    ///
    /// An allow list can have a maximum of 50 tags. Each tag consists of a tag key
    /// and an associated tag value. The maximum length of a tag key is 128
    /// characters. The maximum length of a tag value is 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .criteria = "criteria",
        .description = "description",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateAllowListOutput = struct {
    /// The Amazon Resource Name (ARN) of the allow list.
    arn: ?[]const u8 = null,

    /// The unique identifier for the allow list.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAllowListInput, options: CallOptions) !CreateAllowListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAllowListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/allow-lists";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"criteria\":");
    try aws.json.writeValue(@TypeOf(input.criteria), input.criteria, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAllowListOutput {
    const result: CreateAllowListOutput = try aws.json.parseJsonObject(
        CreateAllowListOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

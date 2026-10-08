const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RetrieverConfiguration = @import("retriever_configuration.zig").RetrieverConfiguration;
const Tag = @import("tag.zig").Tag;
const RetrieverType = @import("retriever_type.zig").RetrieverType;

pub const CreateRetrieverInput = struct {
    /// The identifier of your Amazon Q Business application.
    application_id: []const u8,

    /// A token that you provide to identify the request to create your Amazon Q
    /// Business application retriever.
    client_token: ?[]const u8 = null,

    configuration: RetrieverConfiguration,

    /// The name of your retriever.
    display_name: []const u8,

    /// The ARN of an IAM role used by Amazon Q Business to access the basic
    /// authentication credentials stored in a Secrets Manager secret.
    role_arn: ?[]const u8 = null,

    /// A list of key-value pairs that identify or categorize the retriever. You can
    /// also use tags to help control access to the retriever. Tag keys and values
    /// can consist of Unicode letters, digits, white space, and any of the
    /// following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    /// The type of retriever you are using.
    type: RetrieverType,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .client_token = "clientToken",
        .configuration = "configuration",
        .display_name = "displayName",
        .role_arn = "roleArn",
        .tags = "tags",
        .type = "type",
    };
};

pub const CreateRetrieverOutput = struct {
    /// The Amazon Resource Name (ARN) of an IAM role associated with a retriever.
    retriever_arn: ?[]const u8 = null,

    /// The identifier of the retriever you are using.
    retriever_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .retriever_arn = "retrieverArn",
        .retriever_id = "retrieverId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRetrieverInput, options: CallOptions) !CreateRetrieverOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRetrieverInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/retrievers");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"displayName\":");
    try aws.json.writeValue(@TypeOf(input.display_name), input.display_name, allocator, &body_buf);
    has_prev = true;
    if (input.role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"type\":");
    try aws.json.writeValue(@TypeOf(input.type), input.type, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRetrieverOutput {
    const result: CreateRetrieverOutput = try aws.json.parseJsonObject(
        CreateRetrieverOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexState = @import("index_state.zig").IndexState;

pub const CreateIndexInput = struct {
    /// This value helps ensure idempotency. Resource Explorer uses this value to
    /// prevent the accidental creation of duplicate versions. We recommend that you
    /// generate a [UUID-type
    /// value](https://wikipedia.org/wiki/Universally_unique_identifier) to ensure
    /// the uniqueness of your index.
    client_token: ?[]const u8 = null,

    /// The specified tags are attached only to the index created in this Amazon Web
    /// Services Region. The tags aren't attached to any of the resources listed in
    /// the index.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .tags = "Tags",
    };
};

pub const CreateIndexOutput = struct {
    /// The ARN of the new local index for the Region. You can reference this ARN in
    /// IAM permission policies to authorize the following operations: DeleteIndex |
    /// GetIndex | UpdateIndexType | CreateView
    arn: ?[]const u8 = null,

    /// The date and timestamp when the index was created.
    created_at: ?i64 = null,

    /// Indicates the current state of the index. You can check for changes to the
    /// state for asynchronous operations by calling the GetIndex operation.
    ///
    /// The state can remain in the `CREATING` or `UPDATING` state for several hours
    /// as Resource Explorer discovers the information about your resources and
    /// populates the index.
    state: ?IndexState = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIndexInput, options: CallOptions) !CreateIndexOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-explorer-2", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateIndex";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    var result: CreateIndexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateIndexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

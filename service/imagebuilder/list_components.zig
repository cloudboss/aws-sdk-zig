const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Ownership = @import("ownership.zig").Ownership;
const ComponentVersion = @import("component_version.zig").ComponentVersion;

pub const ListComponentsInput = struct {
    /// Returns the list of components for the specified name.
    by_name: ?bool = null,

    /// Use the following filters to streamline results:
    ///
    /// * `description`
    ///
    /// * `name`
    ///
    /// * `platform`
    ///
    /// * `supportedOsVersion`
    ///
    /// * `type`
    ///
    /// * `version`
    filters: ?[]const Filter = null,

    /// Specify the maximum number of items to return in a request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. This is the nextToken
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// Filters results based on the type of owner for the component. By default,
    /// this request
    /// returns a list of components that your account owns. To see results for
    /// other types of
    /// owners, you can specify components that Amazon manages, third party
    /// components, or
    /// components that other accounts have shared with you.
    owner: ?Ownership = null,

    pub const json_field_names = .{
        .by_name = "byName",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .owner = "owner",
    };
};

pub const ListComponentsOutput = struct {
    /// The list of component semantic versions.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    component_version_list: ?[]const ComponentVersion = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .component_version_list = "componentVersionList",
        .next_token = "nextToken",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListComponentsInput, options: CallOptions) !ListComponentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListComponentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListComponents";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.by_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"byName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"owner\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListComponentsOutput {
    var result: ListComponentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListComponentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

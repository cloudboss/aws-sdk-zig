const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Ownership = @import("ownership.zig").Ownership;
const ImageVersion = @import("image_version.zig").ImageVersion;

pub const ListImagesInput = struct {
    /// Specifies whether to return one entry per image name, with all versions of
    /// each image aggregated. Defaults to `false`, which returns one
    /// entry per image version. You can't combine this option with the
    /// `version` filter.
    by_name: ?bool = null,

    /// Use the following filters to streamline results:
    ///
    /// * `name`
    ///
    /// * `osVersion`
    ///
    /// * `platform`
    ///
    /// * `type`
    ///
    /// * `version`
    filters: ?[]const Filter = null,

    /// Specifies whether to include deprecated Amazon-managed images in the
    /// results. Deprecated images that you own are always returned. Defaults to
    /// `false`.
    include_deprecated: ?bool = null,

    /// The maximum number of items to return in a single request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. Use the `nextToken` value
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    /// Filters the list to images owned by you, by Amazon, or shared with you by
    /// other accounts.
    /// By default, only your account's images are returned.
    owner: ?Ownership = null,

    pub const json_field_names = .{
        .by_name = "byName",
        .filters = "filters",
        .include_deprecated = "includeDeprecated",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .owner = "owner",
    };
};

pub const ListImagesOutput = struct {
    /// The list of image semantic versions.
    ///
    /// The semantic version has four nodes: ../.
    /// You can assign values for the first three, and can filter on all of them.
    ///
    /// **Filtering:** You can use wildcards (x) to specify the most recent versions
    /// or nodes when
    /// selecting the base image or components for your recipe. When you use a
    /// wildcard in any node, all nodes
    /// to the right of the first wildcard must also be wildcards.
    image_version_list: ?[]const ImageVersion = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .image_version_list = "imageVersionList",
        .next_token = "nextToken",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImagesInput, options: CallOptions) !ListImagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListImages";

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
    if (input.include_deprecated) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeDeprecated\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImagesOutput {
    const result: ListImagesOutput = try aws.json.parseJsonObject(
        ListImagesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

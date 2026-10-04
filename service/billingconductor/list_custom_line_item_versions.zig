const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListCustomLineItemVersionsFilter = @import("list_custom_line_item_versions_filter.zig").ListCustomLineItemVersionsFilter;
const CustomLineItemVersionListElement = @import("custom_line_item_version_list_element.zig").CustomLineItemVersionListElement;

pub const ListCustomLineItemVersionsInput = struct {
    /// The Amazon Resource Name (ARN) for the custom line item.
    arn: []const u8,

    /// A `ListCustomLineItemVersionsFilter` that specifies the billing period range
    /// in which the custom line item versions are applied.
    filters: ?ListCustomLineItemVersionsFilter = null,

    /// The maximum number of custom line item versions to retrieve.
    max_results: ?i32 = null,

    /// The pagination token that's used on subsequent calls to retrieve custom line
    /// item versions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListCustomLineItemVersionsOutput = struct {
    /// A list of `CustomLineItemVersionListElements` that are received.
    custom_line_item_versions: ?[]const CustomLineItemVersionListElement = null,

    /// The pagination token that's used on subsequent calls to retrieve custom line
    /// item versions.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_line_item_versions = "CustomLineItemVersions",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCustomLineItemVersionsInput, options: CallOptions) !ListCustomLineItemVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billingconductor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCustomLineItemVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-custom-line-item-versions";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCustomLineItemVersionsOutput {
    const result: ListCustomLineItemVersionsOutput = try aws.json.parseJsonObject(
        ListCustomLineItemVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

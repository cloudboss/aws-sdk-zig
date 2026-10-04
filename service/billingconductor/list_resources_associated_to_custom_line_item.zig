const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListResourcesAssociatedToCustomLineItemFilter = @import("list_resources_associated_to_custom_line_item_filter.zig").ListResourcesAssociatedToCustomLineItemFilter;
const ListResourcesAssociatedToCustomLineItemResponseElement = @import("list_resources_associated_to_custom_line_item_response_element.zig").ListResourcesAssociatedToCustomLineItemResponseElement;

pub const ListResourcesAssociatedToCustomLineItemInput = struct {
    /// The ARN of the custom line item for which the resource associations will be
    /// listed.
    arn: []const u8,

    /// The billing period for which the resource associations will be listed.
    billing_period: ?[]const u8 = null,

    /// (Optional) A `ListResourcesAssociatedToCustomLineItemFilter` that can
    /// specify the types of resources that should be retrieved.
    filters: ?ListResourcesAssociatedToCustomLineItemFilter = null,

    /// (Optional) The maximum number of resource associations to be retrieved.
    max_results: ?i32 = null,

    /// (Optional) The pagination token that's returned by a previous request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .billing_period = "BillingPeriod",
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListResourcesAssociatedToCustomLineItemOutput = struct {
    /// The custom line item ARN for which the resource associations are listed.
    arn: ?[]const u8 = null,

    /// A list of `ListResourcesAssociatedToCustomLineItemResponseElement` for each
    /// resource association retrieved.
    associated_resources: ?[]const ListResourcesAssociatedToCustomLineItemResponseElement = null,

    /// The pagination token to be used in subsequent requests to retrieve
    /// additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_resources = "AssociatedResources",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListResourcesAssociatedToCustomLineItemInput, options: CallOptions) !ListResourcesAssociatedToCustomLineItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListResourcesAssociatedToCustomLineItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-resources-associated-to-custom-line-item";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.billing_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BillingPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListResourcesAssociatedToCustomLineItemOutput {
    const result: ListResourcesAssociatedToCustomLineItemOutput = try aws.json.parseJsonObject(
        ListResourcesAssociatedToCustomLineItemOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

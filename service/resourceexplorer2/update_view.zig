const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SearchFilter = @import("search_filter.zig").SearchFilter;
const IncludedProperty = @import("included_property.zig").IncludedProperty;
const View = @import("view.zig").View;

pub const UpdateViewInput = struct {
    /// An array of strings that specify which resources are included in the results
    /// of queries made using this view. When you use this view in a Search
    /// operation, the filter string is combined with the search's `QueryString`
    /// parameter using a logical `AND` operator.
    ///
    /// For information about the supported syntax, see [Search query reference for
    /// Resource
    /// Explorer](https://docs.aws.amazon.com/resource-explorer/latest/userguide/using-search-query-syntax.html) in the *Amazon Web Services Resource Explorer User Guide*.
    ///
    /// This query string in the context of this operation supports only [filter
    /// prefixes](https://docs.aws.amazon.com/resource-explorer/latest/userguide/using-search-query-syntax.html#query-syntax-filters) with optional [operators](https://docs.aws.amazon.com/resource-explorer/latest/userguide/using-search-query-syntax.html#query-syntax-operators). It doesn't support free-form text. For example, the string `region:us* service:ec2 -tag:stage=prod` includes all Amazon EC2 resources in any Amazon Web Services Region that begins with the letters `us` and is *not* tagged with a key `Stage` that has the value `prod`.
    filters: ?SearchFilter = null,

    /// Specifies optional fields that you want included in search results from this
    /// view. It is a list of objects that each describe a field to include.
    ///
    /// The default is an empty list, with no optional fields included in the
    /// results.
    included_properties: ?[]const IncludedProperty = null,

    /// The [Amazon resource name
    /// (ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) of the view that you want to modify.
    view_arn: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .included_properties = "IncludedProperties",
        .view_arn = "ViewArn",
    };
};

pub const UpdateViewOutput = struct {
    /// Details about the view that you changed with this operation.
    view: ?View = null,

    pub const json_field_names = .{
        .view = "View",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateViewInput, options: CallOptions) !UpdateViewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateView";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.included_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IncludedProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ViewArn\":");
    try aws.json.writeValue(@TypeOf(input.view_arn), input.view_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateViewOutput {
    var result: UpdateViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

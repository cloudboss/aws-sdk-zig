const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceQuery = @import("resource_query.zig").ResourceQuery;
const QueryError = @import("query_error.zig").QueryError;
const ResourceIdentifier = @import("resource_identifier.zig").ResourceIdentifier;

pub const SearchResourcesInput = struct {
    /// The total number of results that you want included on each page of the
    /// response. If you do not include this parameter, it defaults to a value that
    /// is specific to the
    /// operation. If additional items exist beyond the maximum you specify, the
    /// `NextToken`
    /// response element is present and has a value (is not null). Include that
    /// value as the
    /// `NextToken` request parameter in the next call to the operation to get the
    /// next part
    /// of the results. Note that the service might return fewer results than the
    /// maximum even when there
    /// are more results available. You should check `NextToken` after every
    /// operation to
    /// ensure that you receive all of the results.
    max_results: ?i32 = null,

    /// The parameter for receiving additional results if you receive a
    /// `NextToken` response in a previous request. A `NextToken` response
    /// indicates that more output is available. Set this parameter to the value
    /// provided by a previous
    /// call's `NextToken` response to indicate where the output should continue
    /// from.
    next_token: ?[]const u8 = null,

    /// The search query, using the same formats that are supported for resource
    /// group
    /// definition. For more information, see CreateGroup.
    resource_query: ResourceQuery,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_query = "ResourceQuery",
    };
};

pub const SearchResourcesOutput = struct {
    /// If present, indicates that more output is available than is
    /// included in the current response. Use this value in the `NextToken` request
    /// parameter
    /// in a subsequent call to the operation to get the next part of the output.
    /// You should repeat this
    /// until the `NextToken` response element comes back as `null`.
    next_token: ?[]const u8 = null,

    /// A list of `QueryError` objects. Each error contains an
    /// `ErrorCode` and `Message`.
    ///
    /// Possible values for `ErrorCode`:
    ///
    /// * `CLOUDFORMATION_STACK_INACTIVE`
    ///
    /// * `CLOUDFORMATION_STACK_NOT_EXISTING`
    ///
    /// * `CLOUDFORMATION_STACK_UNASSUMABLE_ROLE `
    query_errors: ?[]const QueryError = null,

    /// The ARNs and resource types of resources that are members of the group that
    /// you
    /// specified.
    resource_identifiers: ?[]const ResourceIdentifier = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .query_errors = "QueryErrors",
        .resource_identifiers = "ResourceIdentifiers",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchResourcesInput, options: CallOptions) !SearchResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/resources/search";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResourceQuery\":");
    try aws.json.writeValue(@TypeOf(input.resource_query), input.resource_query, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchResourcesOutput {
    var result: SearchResourcesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SearchResourcesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

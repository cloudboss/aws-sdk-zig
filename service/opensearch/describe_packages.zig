const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DescribePackagesFilter = @import("describe_packages_filter.zig").DescribePackagesFilter;
const PackageDetails = @import("package_details.zig").PackageDetails;

pub const DescribePackagesInput = struct {
    /// Only returns packages that match the `DescribePackagesFilterList`
    /// values.
    filters: ?[]const DescribePackagesFilter = null,

    /// An optional parameter that specifies the maximum number of results to
    /// return. You can
    /// use `nextToken` to get the next page of results.
    max_results: ?i32 = null,

    /// If your initial `DescribePackageFilters` operation returns a
    /// `nextToken`, you can include the returned `nextToken` in
    /// subsequent `DescribePackageFilters` operations, which returns results in the
    /// next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const DescribePackagesOutput = struct {
    /// When `nextToken` is returned, there are more results available. The value
    /// of `nextToken` is a unique pagination token for each page. Send the request
    /// again using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// Basic information about a package.
    package_details_list: ?[]const PackageDetails = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .package_details_list = "PackageDetailsList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePackagesInput, options: CallOptions) !DescribePackagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePackagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/packages/describe";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePackagesOutput {
    const result: DescribePackagesOutput = try aws.json.parseJsonObject(
        DescribePackagesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

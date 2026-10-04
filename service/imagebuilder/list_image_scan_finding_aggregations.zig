const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ImageScanFindingAggregation = @import("image_scan_finding_aggregation.zig").ImageScanFindingAggregation;

pub const ListImageScanFindingAggregationsInput = struct {
    /// A filter name and value pair that determines the type of aggregation
    /// that Image Builder returns. Use one of the following filter names:
    ///
    /// * `imageBuildVersionArn`
    ///
    /// * `imagePipelineArn`
    ///
    /// * `vulnerabilityId`
    ///
    /// If you don't specify a filter, Image Builder returns an aggregation for your
    /// account.
    filter: ?Filter = null,

    /// A token to specify where to start paginating. Use the `nextToken` value
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .next_token = "nextToken",
    };
};

pub const ListImageScanFindingAggregationsOutput = struct {
    /// The aggregation type specifies what type of key is used to group the image
    /// scan
    /// findings. Image Builder returns results based on the request filter. If you
    /// didn't specify a
    /// filter in the request, the type defaults to `accountId`.
    ///
    /// **Aggregation types**
    ///
    /// * accountId
    ///
    /// * imageBuildVersionArn
    ///
    /// * imagePipelineArn
    ///
    /// * vulnerabilityId
    ///
    /// Each aggregation includes counts by severity level for medium severity and
    /// higher
    /// level findings, plus a total for all of the findings for each key value.
    aggregation_type: ?[]const u8 = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    /// An array of image scan finding aggregations that match the filter criteria.
    responses: ?[]const ImageScanFindingAggregation = null,

    pub const json_field_names = .{
        .aggregation_type = "aggregationType",
        .next_token = "nextToken",
        .request_id = "requestId",
        .responses = "responses",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImageScanFindingAggregationsInput, options: CallOptions) !ListImageScanFindingAggregationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImageScanFindingAggregationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListImageScanFindingAggregations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImageScanFindingAggregationsOutput {
    const result: ListImageScanFindingAggregationsOutput = try aws.json.parseJsonObject(
        ListImageScanFindingAggregationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

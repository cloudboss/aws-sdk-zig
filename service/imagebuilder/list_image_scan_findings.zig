const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageScanFindingsFilter = @import("image_scan_findings_filter.zig").ImageScanFindingsFilter;
const ImageScanFinding = @import("image_scan_finding.zig").ImageScanFinding;

pub const ListImageScanFindingsInput = struct {
    /// An array of name value pairs that you can use to filter your results. You
    /// can use the
    /// following filters to streamline results:
    ///
    /// * `imageBuildVersionArn`
    ///
    /// * `imagePipelineArn`
    ///
    /// * `vulnerabilityId`
    ///
    /// * `severity`
    ///
    /// If you don't request a filter, then all findings in your account are listed.
    filters: ?[]const ImageScanFindingsFilter = null,

    /// Specify the maximum number of items to return in a request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. This is the nextToken
    /// from a previously truncated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListImageScanFindingsOutput = struct {
    /// The image scan findings for your account that meet your request filter
    /// criteria.
    findings: ?[]const ImageScanFinding = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token
    /// with the next request to retrieve additional objects.
    next_token: ?[]const u8 = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .findings = "findings",
        .next_token = "nextToken",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImageScanFindingsInput, options: CallOptions) !ListImageScanFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImageScanFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListImageScanFindings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImageScanFindingsOutput {
    var result: ListImageScanFindingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListImageScanFindingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

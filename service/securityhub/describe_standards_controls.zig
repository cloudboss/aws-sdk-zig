const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StandardsControl = @import("standards_control.zig").StandardsControl;

pub const DescribeStandardsControlsInput = struct {
    /// The maximum number of security standard controls to return.
    max_results: ?i32 = null,

    /// The token that is required for pagination. On your first call to the
    /// `DescribeStandardsControls` operation, set the value of this parameter to
    /// `NULL`.
    ///
    /// For subsequent calls to the operation, to continue listing data, set the
    /// value of this
    /// parameter to the value returned from the previous response.
    next_token: ?[]const u8 = null,

    /// The ARN of a resource that represents your subscription to a supported
    /// standard. To get
    /// the subscription ARNs of the standards you have enabled, use the
    /// `GetEnabledStandards` operation.
    standards_subscription_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .standards_subscription_arn = "StandardsSubscriptionArn",
    };
};

pub const DescribeStandardsControlsOutput = struct {
    /// A list of security standards controls.
    controls: ?[]const StandardsControl = null,

    /// The pagination token to use to request the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .controls = "Controls",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStandardsControlsInput, options: CallOptions) !DescribeStandardsControlsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStandardsControlsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/standards/controls/");
    try path_buf.appendSlice(allocator, input.standards_subscription_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStandardsControlsOutput {
    const result: DescribeStandardsControlsOutput = try aws.json.parseJsonObject(
        DescribeStandardsControlsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

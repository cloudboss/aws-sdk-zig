const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StandardsControlAssociationSummary = @import("standards_control_association_summary.zig").StandardsControlAssociationSummary;

pub const ListStandardsControlAssociationsInput = struct {
    /// An optional parameter that limits the total results of the API response to
    /// the
    /// specified number. If this parameter isn't provided in the request, the
    /// results include the
    /// first 25 standard and control associations. The results also include a
    /// `NextToken` parameter that you can use in a subsequent API call to get the
    /// next 25 associations. This repeats until all associations for the specified
    /// control are
    /// returned. The number of results is limited by the number of supported
    /// Security Hub CSPM
    /// standards that you've enabled in the calling account.
    max_results: ?i32 = null,

    /// Optional pagination parameter.
    next_token: ?[]const u8 = null,

    /// The identifier of the control (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters) that you
    /// want to determine the enablement status of in each enabled standard.
    security_control_id: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .security_control_id = "SecurityControlId",
    };
};

pub const ListStandardsControlAssociationsOutput = struct {
    /// A pagination parameter that's included in the response only if it was
    /// included in the
    /// request.
    next_token: ?[]const u8 = null,

    /// An array that provides the enablement status and other details for each
    /// security
    /// control that applies to each enabled standard.
    standards_control_association_summaries: ?[]const StandardsControlAssociationSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .standards_control_association_summaries = "StandardsControlAssociationSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListStandardsControlAssociationsInput, options: CallOptions) !ListStandardsControlAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListStandardsControlAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/associations";

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
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "SecurityControlId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.security_control_id);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListStandardsControlAssociationsOutput {
    var result: ListStandardsControlAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListStandardsControlAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

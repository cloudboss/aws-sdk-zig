const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SegmentGroupStructure = @import("segment_group_structure.zig").SegmentGroupStructure;

pub const CreateSegmentEstimateInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The segment query for calculating a segment estimate.
    segment_query: ?SegmentGroupStructure = null,

    /// The segment SQL query.
    segment_sql_query: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .segment_query = "SegmentQuery",
        .segment_sql_query = "SegmentSqlQuery",
    };
};

pub const CreateSegmentEstimateOutput = struct {
    /// The unique name of the domain.
    domain_name: ?[]const u8 = null,

    /// A unique identifier for the resource. The value can be passed to
    /// `GetSegmentEstimate` to retrieve the result of segment estimate
    /// status.
    estimate_id: ?[]const u8 = null,

    /// The status code for the response.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .estimate_id = "EstimateId",
        .status_code = "StatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSegmentEstimateInput, options: CallOptions) !CreateSegmentEstimateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSegmentEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-estimates");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.segment_query) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentQuery\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment_sql_query) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentSqlQuery\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSegmentEstimateOutput {
    var result: CreateSegmentEstimateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSegmentEstimateOutput, body, allocator);
    }
    result.status_code = @intCast(status);
    _ = headers;

    return result;
}

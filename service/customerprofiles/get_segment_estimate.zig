const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EstimateStatus = @import("estimate_status.zig").EstimateStatus;

pub const GetSegmentEstimateInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    /// The query Id passed by a previous `CreateSegmentEstimate` operation.
    estimate_id: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .estimate_id = "EstimateId",
    };
};

pub const GetSegmentEstimateOutput = struct {
    /// The unique name of the domain.
    domain_name: ?[]const u8 = null,

    /// The estimated number of profiles contained in the segment.
    estimate: ?[]const u8 = null,

    /// The `QueryId` which is the same as the value passed in
    /// `QueryId`.
    estimate_id: ?[]const u8 = null,

    /// The error message if there is any error.
    message: ?[]const u8 = null,

    /// The current status of the query.
    status: ?EstimateStatus = null,

    /// The status code of the segment estimate.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .estimate = "Estimate",
        .estimate_id = "EstimateId",
        .message = "Message",
        .status = "Status",
        .status_code = "StatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentEstimateInput, options: CallOptions) !GetSegmentEstimateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-estimates/");
    try path_buf.appendSlice(allocator, input.estimate_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentEstimateOutput {
    var result: GetSegmentEstimateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSegmentEstimateOutput, body, allocator);
    }
    result.status_code = @intCast(status);
    _ = headers;

    return result;
}

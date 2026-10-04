const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingDetailsError = @import("finding_details_error.zig").FindingDetailsError;
const FindingDetail = @import("finding_detail.zig").FindingDetail;

pub const BatchGetFindingDetailsInput = struct {
    /// A list of finding ARNs.
    finding_arns: []const []const u8,

    pub const json_field_names = .{
        .finding_arns = "findingArns",
    };
};

pub const BatchGetFindingDetailsOutput = struct {
    /// Error information for findings that details could not be returned for.
    errors: ?[]const FindingDetailsError = null,

    /// A finding's vulnerability details.
    finding_details: ?[]const FindingDetail = null,

    pub const json_field_names = .{
        .errors = "errors",
        .finding_details = "findingDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetFindingDetailsInput, options: CallOptions) !BatchGetFindingDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetFindingDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findings/details/batch/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"findingArns\":");
    try aws.json.writeValue(@TypeOf(input.finding_arns), input.finding_arns, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetFindingDetailsOutput {
    var result: BatchGetFindingDetailsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetFindingDetailsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

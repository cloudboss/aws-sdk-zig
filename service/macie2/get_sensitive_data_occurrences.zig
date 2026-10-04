const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DetectedDataDetails = @import("detected_data_details.zig").DetectedDataDetails;
const RevealRequestStatus = @import("reveal_request_status.zig").RevealRequestStatus;

pub const GetSensitiveDataOccurrencesInput = struct {
    /// The unique identifier for the finding.
    finding_id: []const u8,

    pub const json_field_names = .{
        .finding_id = "findingId",
    };
};

pub const GetSensitiveDataOccurrencesOutput = struct {
    /// If an error occurred when Amazon Macie attempted to retrieve occurrences of
    /// sensitive data reported by the finding, a description of the error that
    /// occurred. This value is null if the status (status) of the request is
    /// PROCESSING or SUCCESS.
    @"error": ?[]const u8 = null,

    /// A map that specifies 1-100 types of sensitive data reported by the finding
    /// and, for each type, 1-10 occurrences of sensitive data.
    sensitive_data_occurrences: ?[]const aws.map.MapEntry([]const DetectedDataDetails) = null,

    /// The status of the request to retrieve occurrences of sensitive data reported
    /// by the finding. Possible values are:
    ///
    /// * ERROR - An error occurred when Amazon Macie attempted to locate, retrieve,
    ///   or encrypt the sensitive data. The error value indicates the nature of the
    ///   error that occurred.
    /// * PROCESSING - Macie is processing the request.
    /// * SUCCESS - Macie successfully located, retrieved, and encrypted the
    ///   sensitive data.
    status: ?RevealRequestStatus = null,

    pub const json_field_names = .{
        .@"error" = "error",
        .sensitive_data_occurrences = "sensitiveDataOccurrences",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSensitiveDataOccurrencesInput, options: CallOptions) !GetSensitiveDataOccurrencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSensitiveDataOccurrencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/findings/");
    try path_buf.appendSlice(allocator, input.finding_id);
    try path_buf.appendSlice(allocator, "/reveal");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSensitiveDataOccurrencesOutput {
    var result: GetSensitiveDataOccurrencesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSensitiveDataOccurrencesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

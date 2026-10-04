const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Communication = @import("communication.zig").Communication;

pub const DescribeCommunicationsInput = struct {
    /// The start date for a filtered date search on support case communications.
    /// Case
    /// communications are available for 24 months after creation.
    after_time: ?[]const u8 = null,

    /// The end date for a filtered date search on support case communications. Case
    /// communications are available for 24 months after creation.
    before_time: ?[]const u8 = null,

    /// The support case ID requested or returned in the call. The case ID is an
    /// alphanumeric
    /// string formatted as shown in this example:
    /// case-*12345678910-exen-2025-c4c1d2bf33c5cf47*
    case_id: []const u8,

    /// Specifies whether to validate the request without actually returning
    /// communications. When
    /// set to `true`, the request is validated but no communications are returned,
    /// and the
    /// operation returns a `DryRunOperationException`. When omitted or set to
    /// `false`, the request runs normally.
    dry_run: ?bool = null,

    /// The maximum number of results to return before paginating.
    max_results: ?i32 = null,

    /// A resumption point for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .after_time = "afterTime",
        .before_time = "beforeTime",
        .case_id = "caseId",
        .dry_run = "dryRun",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeCommunicationsOutput = struct {
    /// The communications for the case.
    communications: ?[]const Communication = null,

    /// A resumption point for pagination.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .communications = "communications",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCommunicationsInput, options: CallOptions) !DescribeCommunicationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "support", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCommunicationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("support", "Support", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.DescribeCommunications");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCommunicationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCommunicationsOutput, body, allocator);
}

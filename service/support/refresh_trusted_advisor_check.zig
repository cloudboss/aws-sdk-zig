const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustedAdvisorCheckRefreshStatus = @import("trusted_advisor_check_refresh_status.zig").TrustedAdvisorCheckRefreshStatus;

pub const RefreshTrustedAdvisorCheckInput = struct {
    /// The unique identifier for the Trusted Advisor check to refresh.
    ///
    /// Specifying the check ID of a check that is automatically refreshed causes an
    /// `InvalidParameterValue` error.
    check_id: []const u8,

    pub const json_field_names = .{
        .check_id = "checkId",
    };
};

pub const RefreshTrustedAdvisorCheckOutput = struct {
    /// The current refresh status for a check, including the amount of time until
    /// the check
    /// is eligible for refresh.
    status: ?TrustedAdvisorCheckRefreshStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RefreshTrustedAdvisorCheckInput, options: CallOptions) !RefreshTrustedAdvisorCheckOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RefreshTrustedAdvisorCheckInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSSupport_20130415.RefreshTrustedAdvisorCheck");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RefreshTrustedAdvisorCheckOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RefreshTrustedAdvisorCheckOutput, body, allocator);
}

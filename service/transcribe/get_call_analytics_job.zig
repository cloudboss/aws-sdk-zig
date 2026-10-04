const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CallAnalyticsJob = @import("call_analytics_job.zig").CallAnalyticsJob;

pub const GetCallAnalyticsJobInput = struct {
    /// The name of the Call Analytics job you want information about. Job names are
    /// case
    /// sensitive.
    call_analytics_job_name: []const u8,

    pub const json_field_names = .{
        .call_analytics_job_name = "CallAnalyticsJobName",
    };
};

pub const GetCallAnalyticsJobOutput = struct {
    /// Provides detailed information about the specified Call Analytics job,
    /// including job
    /// status and, if applicable, failure reason.
    call_analytics_job: ?CallAnalyticsJob = null,

    pub const json_field_names = .{
        .call_analytics_job = "CallAnalyticsJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCallAnalyticsJobInput, options: CallOptions) !GetCallAnalyticsJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transcribe", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCallAnalyticsJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.GetCallAnalyticsJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCallAnalyticsJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCallAnalyticsJobOutput, body, allocator);
}

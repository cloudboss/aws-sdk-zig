const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailureDetails = @import("failure_details.zig").FailureDetails;

pub const PutThirdPartyJobFailureResultInput = struct {
    /// The clientToken portion of the clientId and clientToken pair used to verify
    /// that
    /// the calling entity is allowed access to the job and its details.
    client_token: []const u8,

    /// Represents information about failure details.
    failure_details: FailureDetails,

    /// The ID of the job that failed. This is the same ID returned from
    /// `PollForThirdPartyJobs`.
    job_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .failure_details = "failureDetails",
        .job_id = "jobId",
    };
};

pub const PutThirdPartyJobFailureResultOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutThirdPartyJobFailureResultInput, options: CallOptions) !PutThirdPartyJobFailureResultOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codepipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutThirdPartyJobFailureResultInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codepipeline", "CodePipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.PutThirdPartyJobFailureResult");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutThirdPartyJobFailureResultOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

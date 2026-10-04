const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThirdPartyJobDetails = @import("third_party_job_details.zig").ThirdPartyJobDetails;

pub const GetThirdPartyJobDetailsInput = struct {
    /// The clientToken portion of the clientId and clientToken pair used to verify
    /// that
    /// the calling entity is allowed access to the job and its details.
    client_token: []const u8,

    /// The unique system-generated ID used for identifying the job.
    job_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .job_id = "jobId",
    };
};

pub const GetThirdPartyJobDetailsOutput = struct {
    /// The details of the job, including any protected values defined for the
    /// job.
    job_details: ?ThirdPartyJobDetails = null,

    pub const json_field_names = .{
        .job_details = "jobDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetThirdPartyJobDetailsInput, options: CallOptions) !GetThirdPartyJobDetailsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetThirdPartyJobDetailsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.GetThirdPartyJobDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetThirdPartyJobDetailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetThirdPartyJobDetailsOutput, body, allocator);
}

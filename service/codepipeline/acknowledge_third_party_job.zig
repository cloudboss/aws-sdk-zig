const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobStatus = @import("job_status.zig").JobStatus;

pub const AcknowledgeThirdPartyJobInput = struct {
    /// The clientToken portion of the clientId and clientToken pair used to verify
    /// that
    /// the calling entity is allowed access to the job and its details.
    client_token: []const u8,

    /// The unique system-generated ID of the job.
    job_id: []const u8,

    /// A system-generated random number that CodePipeline uses to ensure that the
    /// job is being worked on by only one job worker. Get this number from the
    /// response to a
    /// GetThirdPartyJobDetails request.
    nonce: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .job_id = "jobId",
        .nonce = "nonce",
    };
};

pub const AcknowledgeThirdPartyJobOutput = struct {
    /// The status information for the third party job, if any.
    status: ?JobStatus = null,

    pub const json_field_names = .{
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcknowledgeThirdPartyJobInput, options: CallOptions) !AcknowledgeThirdPartyJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AcknowledgeThirdPartyJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CodePipeline_20150709.AcknowledgeThirdPartyJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcknowledgeThirdPartyJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AcknowledgeThirdPartyJobOutput, body, allocator);
}

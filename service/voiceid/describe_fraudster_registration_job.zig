const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FraudsterRegistrationJob = @import("fraudster_registration_job.zig").FraudsterRegistrationJob;

pub const DescribeFraudsterRegistrationJobInput = struct {
    /// The identifier of the domain that contains the fraudster registration job.
    domain_id: []const u8,

    /// The identifier of the fraudster registration job you are describing.
    job_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .job_id = "JobId",
    };
};

pub const DescribeFraudsterRegistrationJobOutput = struct {
    /// Contains details about the specified fraudster registration job.
    job: ?FraudsterRegistrationJob = null,

    pub const json_field_names = .{
        .job = "Job",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFraudsterRegistrationJobInput, options: CallOptions) !DescribeFraudsterRegistrationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "voiceid", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFraudsterRegistrationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voiceid", "Voice ID", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "VoiceID.DescribeFraudsterRegistrationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFraudsterRegistrationJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFraudsterRegistrationJobOutput, body, allocator);
}

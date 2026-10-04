const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TranscriptionJob = @import("transcription_job.zig").TranscriptionJob;

pub const GetTranscriptionJobInput = struct {
    /// The name of the transcription job you want information about. Job names are
    /// case
    /// sensitive.
    transcription_job_name: []const u8,

    pub const json_field_names = .{
        .transcription_job_name = "TranscriptionJobName",
    };
};

pub const GetTranscriptionJobOutput = struct {
    /// Provides detailed information about the specified transcription job,
    /// including job
    /// status and, if applicable, failure reason.
    transcription_job: ?TranscriptionJob = null,

    pub const json_field_names = .{
        .transcription_job = "TranscriptionJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTranscriptionJobInput, options: CallOptions) !GetTranscriptionJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTranscriptionJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.GetTranscriptionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTranscriptionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTranscriptionJobOutput, body, allocator);
}

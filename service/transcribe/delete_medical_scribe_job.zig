const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteMedicalScribeJobInput = struct {
    /// The name of the Medical Scribe job you want to delete. Job names are case
    /// sensitive.
    medical_scribe_job_name: []const u8,

    pub const json_field_names = .{
        .medical_scribe_job_name = "MedicalScribeJobName",
    };
};

pub const DeleteMedicalScribeJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteMedicalScribeJobInput, options: CallOptions) !DeleteMedicalScribeJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteMedicalScribeJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.DeleteMedicalScribeJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteMedicalScribeJobOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DominantLanguageDetectionJobProperties = @import("dominant_language_detection_job_properties.zig").DominantLanguageDetectionJobProperties;

pub const DescribeDominantLanguageDetectionJobInput = struct {
    /// The identifier that Amazon Comprehend generated for the job. The
    /// `StartDominantLanguageDetectionJob` operation returns this identifier in its
    /// response.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribeDominantLanguageDetectionJobOutput = struct {
    /// An object that contains the properties associated with a dominant language
    /// detection
    /// job.
    dominant_language_detection_job_properties: ?DominantLanguageDetectionJobProperties = null,

    pub const json_field_names = .{
        .dominant_language_detection_job_properties = "DominantLanguageDetectionJobProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDominantLanguageDetectionJobInput, options: CallOptions) !DescribeDominantLanguageDetectionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDominantLanguageDetectionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DescribeDominantLanguageDetectionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDominantLanguageDetectionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDominantLanguageDetectionJobOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComprehendMedicalAsyncJobProperties = @import("comprehend_medical_async_job_properties.zig").ComprehendMedicalAsyncJobProperties;

pub const DescribeEntitiesDetectionV2JobInput = struct {
    /// The identifier that Amazon Comprehend Medical generated for the job. The
    /// `StartEntitiesDetectionV2Job` operation returns this identifier in its
    /// response.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const DescribeEntitiesDetectionV2JobOutput = struct {
    /// An object that contains the properties associated with a detection job.
    comprehend_medical_async_job_properties: ?ComprehendMedicalAsyncJobProperties = null,

    pub const json_field_names = .{
        .comprehend_medical_async_job_properties = "ComprehendMedicalAsyncJobProperties",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeEntitiesDetectionV2JobInput, options: CallOptions) !DescribeEntitiesDetectionV2JobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehendmedical", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeEntitiesDetectionV2JobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehendmedical", "ComprehendMedical", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ComprehendMedical_20181030.DescribeEntitiesDetectionV2Job");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeEntitiesDetectionV2JobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeEntitiesDetectionV2JobOutput, body, allocator);
}

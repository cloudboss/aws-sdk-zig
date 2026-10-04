const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobCategory = @import("job_category.zig").JobCategory;

pub const DescribeJobSchemaVersionInput = struct {
    /// The category of the job schema to describe.
    job_category: JobCategory,

    /// The version of the schema to retrieve. If not specified, the latest version
    /// is returned.
    job_config_schema_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_category = "JobCategory",
        .job_config_schema_version = "JobConfigSchemaVersion",
    };
};

pub const DescribeJobSchemaVersionOutput = struct {
    /// The category of the job schema.
    job_category: JobCategory,

    /// The JSON schema document that defines the structure of the job
    /// configuration.
    job_config_schema: []const u8,

    /// The version of the schema.
    job_config_schema_version: []const u8,

    pub const json_field_names = .{
        .job_category = "JobCategory",
        .job_config_schema = "JobConfigSchema",
        .job_config_schema_version = "JobConfigSchemaVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeJobSchemaVersionInput, options: CallOptions) !DescribeJobSchemaVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeJobSchemaVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeJobSchemaVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeJobSchemaVersionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeJobSchemaVersionOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobCategory = @import("job_category.zig").JobCategory;
const JobConfigSchemaVersionSummary = @import("job_config_schema_version_summary.zig").JobConfigSchemaVersionSummary;

pub const ListJobSchemaVersionsInput = struct {
    /// The category of job schemas to list.
    job_category: JobCategory,

    /// The maximum number of schema versions to return in the response. The default
    /// value is 5.
    max_results: ?i32 = null,

    /// If the previous response was truncated, this token retrieves the next set of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_category = "JobCategory",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListJobSchemaVersionsOutput = struct {
    /// An array of `JobConfigSchemaVersionSummary` objects listing the available
    /// schema versions.
    job_config_schemas: ?[]const JobConfigSchemaVersionSummary = null,

    /// If the response is truncated, this token retrieves the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_config_schemas = "JobConfigSchemas",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobSchemaVersionsInput, options: CallOptions) !ListJobSchemaVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJobSchemaVersionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListJobSchemaVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJobSchemaVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListJobSchemaVersionsOutput, body, allocator);
}

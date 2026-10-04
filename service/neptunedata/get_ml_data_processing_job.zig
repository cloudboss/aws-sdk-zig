const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MlResourceDefinition = @import("ml_resource_definition.zig").MlResourceDefinition;

pub const GetMLDataProcessingJobInput = struct {
    /// The unique identifier of the data-processing job to be retrieved.
    id: []const u8,

    /// The ARN of an IAM role that provides Neptune access to SageMaker and Amazon
    /// S3 resources. This must be listed in your DB cluster parameter group or an
    /// error will occur.
    neptune_iam_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .neptune_iam_role_arn = "neptuneIamRoleArn",
    };
};

pub const GetMLDataProcessingJobOutput = struct {
    /// The unique identifier of this data-processing job.
    id: ?[]const u8 = null,

    /// Definition of the data processing job.
    processing_job: ?MlResourceDefinition = null,

    /// Status of the data processing job.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .processing_job = "processingJob",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMLDataProcessingJobInput, options: CallOptions) !GetMLDataProcessingJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMLDataProcessingJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/ml/dataprocessing/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.neptune_iam_role_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "neptuneIamRoleArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMLDataProcessingJobOutput {
    const result: GetMLDataProcessingJobOutput = try aws.json.parseJsonObject(
        GetMLDataProcessingJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

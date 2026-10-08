const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateBatchImportJobInput = struct {
    /// The name of the event type.
    event_type_name: []const u8,

    /// The ARN of the IAM role created for Amazon S3 bucket that holds your data
    /// file.
    ///
    /// The IAM role must have read permissions to your input S3 bucket and write
    /// permissions to your output S3 bucket.
    /// For more information about bucket permissions, see [User policy
    /// examples](https://docs.aws.amazon.com/AmazonS3/latest/userguide/example-policies-s3.html) in the
    /// *Amazon S3 User Guide*.
    iam_role_arn: []const u8,

    /// The URI that points to the Amazon S3 location of your data file.
    input_path: []const u8,

    /// The ID of the batch import job. The ID cannot be of a past job, unless the
    /// job exists in `CREATE_FAILED` state.
    job_id: []const u8,

    /// The URI that points to the Amazon S3 location for storing your results.
    output_path: []const u8,

    /// A collection of key-value pairs associated with this request.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .event_type_name = "eventTypeName",
        .iam_role_arn = "iamRoleArn",
        .input_path = "inputPath",
        .job_id = "jobId",
        .output_path = "outputPath",
        .tags = "tags",
    };
};

pub const CreateBatchImportJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBatchImportJobInput, options: CallOptions) !CreateBatchImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBatchImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.CreateBatchImportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBatchImportJobOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

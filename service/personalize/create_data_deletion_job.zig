const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;
const Tag = @import("tag.zig").Tag;

pub const CreateDataDeletionJobInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset group that has the datasets
    /// you want to
    /// delete records from.
    dataset_group_arn: []const u8,

    /// The Amazon S3 bucket that contains the list of userIds of the users to
    /// delete.
    data_source: DataSource,

    /// The name for the data deletion job.
    job_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that has permissions to read
    /// from the Amazon S3
    /// data source.
    role_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the data deletion job.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .dataset_group_arn = "datasetGroupArn",
        .data_source = "dataSource",
        .job_name = "jobName",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateDataDeletionJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the data deletion job.
    data_deletion_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_deletion_job_arn = "dataDeletionJobArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataDeletionJobInput, options: CallOptions) !CreateDataDeletionJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataDeletionJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateDataDeletionJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataDeletionJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataDeletionJobOutput, body, allocator);
}

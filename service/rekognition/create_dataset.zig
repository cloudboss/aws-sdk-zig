const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetSource = @import("dataset_source.zig").DatasetSource;
const DatasetType = @import("dataset_type.zig").DatasetType;

pub const CreateDatasetInput = struct {
    /// The source files for the dataset. You can specify the ARN of an existing
    /// dataset or specify the Amazon S3 bucket location
    /// of an Amazon Sagemaker format manifest file. If you don't specify
    /// `datasetSource`, an empty dataset is created.
    /// To add labeled images to the dataset, You can use the console or call
    /// UpdateDatasetEntries.
    dataset_source: ?DatasetSource = null,

    /// The type of the dataset. Specify `TRAIN` to create a training dataset.
    /// Specify `TEST`
    /// to create a test dataset.
    dataset_type: DatasetType,

    /// The ARN of the Amazon Rekognition Custom Labels project to which you want to
    /// asssign the dataset.
    project_arn: []const u8,

    /// A set of tags (key-value pairs) that you want to attach to the dataset.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .dataset_source = "DatasetSource",
        .dataset_type = "DatasetType",
        .project_arn = "ProjectArn",
        .tags = "Tags",
    };
};

pub const CreateDatasetOutput = struct {
    /// The ARN of the created Amazon Rekognition Custom Labels dataset.
    dataset_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetInput, options: CallOptions) !CreateDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CreateDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
}

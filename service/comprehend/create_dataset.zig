const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetType = @import("dataset_type.zig").DatasetType;
const DatasetInputDataConfig = @import("dataset_input_data_config.zig").DatasetInputDataConfig;
const Tag = @import("tag.zig").Tag;

pub const CreateDatasetInput = struct {
    /// A unique identifier for the request. If you don't set the client request
    /// token, Amazon
    /// Comprehend generates one.
    client_request_token: ?[]const u8 = null,

    /// Name of the dataset.
    dataset_name: []const u8,

    /// The dataset type. You can specify that the data in a dataset is for training
    /// the model or for testing the model.
    dataset_type: ?DatasetType = null,

    /// Description of the dataset.
    description: ?[]const u8 = null,

    /// The Amazon Resource Number (ARN) of the flywheel of the flywheel to receive
    /// the data.
    flywheel_arn: []const u8,

    /// Information about the input data configuration. The type of input data
    /// varies based
    /// on the format of the input and whether the data is for a classifier model or
    /// an entity recognition model.
    input_data_config: DatasetInputDataConfig,

    /// Tags for the dataset.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .dataset_name = "DatasetName",
        .dataset_type = "DatasetType",
        .description = "Description",
        .flywheel_arn = "FlywheelArn",
        .input_data_config = "InputDataConfig",
        .tags = "Tags",
    };
};

pub const CreateDatasetOutput = struct {
    /// The ARN of the dataset.
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.CreateDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
}

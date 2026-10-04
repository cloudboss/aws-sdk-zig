const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetSchema = @import("dataset_schema.zig").DatasetSchema;
const Tag = @import("tag.zig").Tag;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const CreateDatasetInput = struct {
    /// A unique identifier for the request. If you do not set the client request
    /// token, Amazon
    /// Lookout for Equipment generates one.
    client_token: []const u8,

    /// The name of the dataset being created.
    dataset_name: []const u8,

    /// A JSON description of the data that is in each time series dataset,
    /// including names,
    /// column names, and data types.
    dataset_schema: ?DatasetSchema = null,

    /// Provides the identifier of the KMS key used to encrypt dataset data by
    /// Amazon Lookout
    /// for Equipment.
    server_side_kms_key_id: ?[]const u8 = null,

    /// Any tags associated with the ingested data described in the dataset.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .dataset_name = "DatasetName",
        .dataset_schema = "DatasetSchema",
        .server_side_kms_key_id = "ServerSideKmsKeyId",
        .tags = "Tags",
    };
};

pub const CreateDatasetOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset being created.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset being created.
    dataset_name: ?[]const u8 = null,

    /// Indicates the status of the `CreateDataset` operation.
    status: ?DatasetStatus = null,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetInput, options: CallOptions) !CreateDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lookoutequipment", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("lookoutequipment", "LookoutEquipment", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLookoutEquipmentFrontendService.CreateDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
}

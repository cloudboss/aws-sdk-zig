const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DatasetType = @import("dataset_type.zig").DatasetType;
const Domain = @import("domain.zig").Domain;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const Schema = @import("schema.zig").Schema;

pub const DescribeDatasetInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
    };
};

pub const DescribeDatasetOutput = struct {
    /// When the dataset was created.
    creation_time: ?i64 = null,

    /// The frequency of data collection.
    ///
    /// Valid intervals are Y (Year), M (Month), W (Week), D (Day), H (Hour), 30min
    /// (30 minutes),
    /// 15min (15 minutes), 10min (10 minutes), 5min (5 minutes), and 1min (1
    /// minute). For example,
    /// "M" indicates every month and "30min" indicates every 30 minutes.
    data_frequency: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset.
    dataset_name: ?[]const u8 = null,

    /// The dataset type.
    dataset_type: ?DatasetType = null,

    /// The domain associated with the dataset.
    domain: ?Domain = null,

    /// The Key Management Service (KMS) key and the Identity and Access Management
    /// (IAM) role that Amazon Forecast can assume to access
    /// the key.
    encryption_config: ?EncryptionConfig = null,

    /// When you create a dataset, `LastModificationTime` is the same as
    /// `CreationTime`. While data is being imported to the dataset,
    /// `LastModificationTime` is the current time of the `DescribeDataset`
    /// call. After a
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html)
    /// operation has finished, `LastModificationTime` is when the import job
    /// completed or
    /// failed.
    last_modification_time: ?i64 = null,

    /// An array of `SchemaAttribute` objects that specify the dataset fields. Each
    /// `SchemaAttribute` specifies the name and data type of a field.
    schema: ?Schema = null,

    /// The status of the dataset. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// * `UPDATE_PENDING`, `UPDATE_IN_PROGRESS`,
    /// `UPDATE_FAILED`
    ///
    /// The `UPDATE` states apply while data is imported to the dataset from a call
    /// to
    /// the
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html) operation and reflect the status of the dataset import job.
    /// For example, when the import job status is `CREATE_IN_PROGRESS`, the status
    /// of the
    /// dataset is `UPDATE_IN_PROGRESS`.
    ///
    /// The `Status` of the dataset must be `ACTIVE` before you can import
    /// training data.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_frequency = "DataFrequency",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .dataset_type = "DatasetType",
        .domain = "Domain",
        .encryption_config = "EncryptionConfig",
        .last_modification_time = "LastModificationTime",
        .schema = "Schema",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetInput, options: CallOptions) !DescribeDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "forecast", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDatasetOutput, body, allocator);
}

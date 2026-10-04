const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AdapterVersionDatasetConfig = @import("adapter_version_dataset_config.zig").AdapterVersionDatasetConfig;
const AdapterVersionEvaluationMetric = @import("adapter_version_evaluation_metric.zig").AdapterVersionEvaluationMetric;
const FeatureType = @import("feature_type.zig").FeatureType;
const OutputConfig = @import("output_config.zig").OutputConfig;
const AdapterVersionStatus = @import("adapter_version_status.zig").AdapterVersionStatus;

pub const GetAdapterVersionInput = struct {
    /// A string specifying a unique ID for the adapter version you want to retrieve
    /// information for.
    adapter_id: []const u8,

    /// A string specifying the adapter version you want to retrieve information
    /// for.
    adapter_version: []const u8,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_version = "AdapterVersion",
    };
};

pub const GetAdapterVersionOutput = struct {
    /// A string containing a unique ID for the adapter version being retrieved.
    adapter_id: ?[]const u8 = null,

    /// A string containing the adapter version that has been retrieved.
    adapter_version: ?[]const u8 = null,

    /// The time that the adapter version was created.
    creation_time: ?i64 = null,

    /// Specifies a dataset used to train a new adapter version. Takes a
    /// ManifestS3Objec as the
    /// value.
    dataset_config: ?AdapterVersionDatasetConfig = null,

    /// The evaluation metrics (F1 score, Precision, and Recall) for the requested
    /// version,
    /// grouped by baseline metrics and adapter version.
    evaluation_metrics: ?[]const AdapterVersionEvaluationMetric = null,

    /// List of the targeted feature types for the requested adapter version.
    feature_types: ?[]const FeatureType = null,

    /// The identifier for your AWS Key Management Service key (AWS KMS key). Used
    /// to encrypt your documents.
    kms_key_id: ?[]const u8 = null,

    output_config: ?OutputConfig = null,

    /// The status of the adapter version that has been requested.
    status: ?AdapterVersionStatus = null,

    /// A message that describes the status of the requested adapter version.
    status_message: ?[]const u8 = null,

    /// A set of tags (key-value pairs) that are associated with the adapter
    /// version.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .adapter_id = "AdapterId",
        .adapter_version = "AdapterVersion",
        .creation_time = "CreationTime",
        .dataset_config = "DatasetConfig",
        .evaluation_metrics = "EvaluationMetrics",
        .feature_types = "FeatureTypes",
        .kms_key_id = "KMSKeyId",
        .output_config = "OutputConfig",
        .status = "Status",
        .status_message = "StatusMessage",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAdapterVersionInput, options: CallOptions) !GetAdapterVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAdapterVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.GetAdapterVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAdapterVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAdapterVersionOutput, body, allocator);
}

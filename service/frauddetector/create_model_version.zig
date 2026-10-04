const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExternalEventsDetail = @import("external_events_detail.zig").ExternalEventsDetail;
const IngestedEventsDetail = @import("ingested_events_detail.zig").IngestedEventsDetail;
const ModelTypeEnum = @import("model_type_enum.zig").ModelTypeEnum;
const Tag = @import("tag.zig").Tag;
const TrainingDataSchema = @import("training_data_schema.zig").TrainingDataSchema;
const TrainingDataSourceEnum = @import("training_data_source_enum.zig").TrainingDataSourceEnum;

pub const CreateModelVersionInput = struct {
    /// Details of the external events data used for model version training.
    /// Required if `trainingDataSource` is `EXTERNAL_EVENTS`.
    external_events_detail: ?ExternalEventsDetail = null,

    /// Details of the ingested events data used for model version training.
    /// Required if `trainingDataSource` is `INGESTED_EVENTS`.
    ingested_events_detail: ?IngestedEventsDetail = null,

    /// The model ID.
    model_id: []const u8,

    /// The model type.
    model_type: ModelTypeEnum,

    /// A collection of key and value pairs.
    tags: ?[]const Tag = null,

    /// The training data schema.
    training_data_schema: TrainingDataSchema,

    /// The training data source location in Amazon S3.
    training_data_source: TrainingDataSourceEnum,

    pub const json_field_names = .{
        .external_events_detail = "externalEventsDetail",
        .ingested_events_detail = "ingestedEventsDetail",
        .model_id = "modelId",
        .model_type = "modelType",
        .tags = "tags",
        .training_data_schema = "trainingDataSchema",
        .training_data_source = "trainingDataSource",
    };
};

pub const CreateModelVersionOutput = struct {
    /// The model ID.
    model_id: ?[]const u8 = null,

    /// The model type.
    model_type: ?ModelTypeEnum = null,

    /// The model version number of the model version created.
    model_version_number: ?[]const u8 = null,

    /// The model version status.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_id = "modelId",
        .model_type = "modelType",
        .model_version_number = "modelVersionNumber",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateModelVersionInput, options: CallOptions) !CreateModelVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateModelVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.CreateModelVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateModelVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateModelVersionOutput, body, allocator);
}

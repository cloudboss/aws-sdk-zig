const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceType = @import("data_source_type.zig").DataSourceType;
const DatasetStatus = @import("dataset_status.zig").DatasetStatus;

pub const AddDatasetExamplesInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The unique identifier of the dataset to add examples to.
    dataset_id: []const u8,

    /// Source of examples to add. Provide either inline examples or an S3 URI
    /// pointing to a JSONL file.
    source: DataSourceType,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .dataset_id = "datasetId",
        .source = "source",
    };
};

pub const AddDatasetExamplesOutput = struct {
    /// The number of examples added.
    added_count: i64,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    /// The unique identifier of the dataset.
    dataset_id: []const u8,

    /// IDs of all added examples (auto-generated UUIDs).
    example_ids: ?[]const []const u8 = null,

    /// The current status of the dataset.
    status: DatasetStatus,

    /// The timestamp when the examples were added.
    updated_at: i64,

    pub const json_field_names = .{
        .added_count = "addedCount",
        .dataset_arn = "datasetArn",
        .dataset_id = "datasetId",
        .example_ids = "exampleIds",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AddDatasetExamplesInput, options: CallOptions) !AddDatasetExamplesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AddDatasetExamplesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datasets/");
    try path_buf.appendSlice(allocator, input.dataset_id);
    try path_buf.appendSlice(allocator, "/examples/add");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AddDatasetExamplesOutput {
    const result: AddDatasetExamplesOutput = try aws.json.parseJsonObject(
        AddDatasetExamplesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

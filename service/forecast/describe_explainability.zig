const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSource = @import("data_source.zig").DataSource;
const ExplainabilityConfig = @import("explainability_config.zig").ExplainabilityConfig;
const Schema = @import("schema.zig").Schema;

pub const DescribeExplainabilityInput = struct {
    /// The Amazon Resource Name (ARN) of the Explaianability to describe.
    explainability_arn: []const u8,

    pub const json_field_names = .{
        .explainability_arn = "ExplainabilityArn",
    };
};

pub const DescribeExplainabilityOutput = struct {
    /// When the Explainability resource was created.
    creation_time: ?i64 = null,

    data_source: ?DataSource = null,

    /// Whether the visualization was enabled for the Explainability resource.
    enable_visualization: ?bool = null,

    /// If `TimePointGranularity` is set to `SPECIFIC`, the last time
    /// point in the Explainability.
    end_date_time: ?[]const u8 = null,

    /// The estimated time remaining in minutes for the CreateExplainability
    /// job to complete.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Explainability.
    explainability_arn: ?[]const u8 = null,

    /// The configuration settings that define the granularity of time series and
    /// time points
    /// for the Explainability.
    explainability_config: ?ExplainabilityConfig = null,

    /// The name of the Explainability.
    explainability_name: ?[]const u8 = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the
    /// job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64 = null,

    /// If an error occurred, a message about the error.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Predictor or Forecast used to create
    /// the
    /// Explainability resource.
    resource_arn: ?[]const u8 = null,

    schema: ?Schema = null,

    /// If `TimePointGranularity` is set to `SPECIFIC`, the first time
    /// point in the Explainability.
    start_date_time: ?[]const u8 = null,

    /// The status of the Explainability resource. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_source = "DataSource",
        .enable_visualization = "EnableVisualization",
        .end_date_time = "EndDateTime",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .explainability_arn = "ExplainabilityArn",
        .explainability_config = "ExplainabilityConfig",
        .explainability_name = "ExplainabilityName",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .resource_arn = "ResourceArn",
        .schema = "Schema",
        .start_date_time = "StartDateTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeExplainabilityInput, options: CallOptions) !DescribeExplainabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeExplainabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeExplainability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeExplainabilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeExplainabilityOutput, body, allocator);
}

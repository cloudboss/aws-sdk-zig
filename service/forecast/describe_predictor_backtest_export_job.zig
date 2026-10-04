const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataDestination = @import("data_destination.zig").DataDestination;

pub const DescribePredictorBacktestExportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the predictor backtest export job.
    predictor_backtest_export_job_arn: []const u8,

    pub const json_field_names = .{
        .predictor_backtest_export_job_arn = "PredictorBacktestExportJobArn",
    };
};

pub const DescribePredictorBacktestExportJobOutput = struct {
    /// When the predictor backtest export job was created.
    creation_time: ?i64 = null,

    destination: ?DataDestination = null,

    /// The format of the exported data, CSV or PARQUET.
    format: ?[]const u8 = null,

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

    /// Information about any errors that may have occurred during the backtest
    /// export.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the predictor.
    predictor_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the predictor backtest export job.
    predictor_backtest_export_job_arn: ?[]const u8 = null,

    /// The name of the predictor backtest export job.
    predictor_backtest_export_job_name: ?[]const u8 = null,

    /// The status of the predictor backtest export job. States include:
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
        .destination = "Destination",
        .format = "Format",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .predictor_arn = "PredictorArn",
        .predictor_backtest_export_job_arn = "PredictorBacktestExportJobArn",
        .predictor_backtest_export_job_name = "PredictorBacktestExportJobName",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePredictorBacktestExportJobInput, options: CallOptions) !DescribePredictorBacktestExportJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePredictorBacktestExportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribePredictorBacktestExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePredictorBacktestExportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribePredictorBacktestExportJobOutput, body, allocator);
}

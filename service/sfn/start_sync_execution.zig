const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const BillingDetails = @import("billing_details.zig").BillingDetails;
const CloudWatchEventsExecutionDataDetails = @import("cloud_watch_events_execution_data_details.zig").CloudWatchEventsExecutionDataDetails;
const SyncExecutionStatus = @import("sync_execution_status.zig").SyncExecutionStatus;

pub const StartSyncExecutionInput = struct {
    /// If your state machine definition is encrypted with a KMS key, callers must
    /// have `kms:Decrypt` permission to decrypt the definition. Alternatively, you
    /// can call the API with `includedData = METADATA_ONLY` to get a successful
    /// response without the encrypted definition.
    included_data: ?IncludedData = null,

    /// The string that contains the JSON input data for the execution, for example:
    ///
    /// `"{\"first_name\" : \"Alejandro\"}"`
    ///
    /// If you don't include any JSON input data, you still must include the two
    /// braces, for
    /// example: `"{}"`
    ///
    /// Length constraints apply to the payload size, and are expressed as bytes in
    /// UTF-8 encoding.
    input: ?[]const u8 = null,

    /// The name of the execution.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the state machine to execute.
    state_machine_arn: []const u8,

    /// Passes the X-Ray trace header. The trace header can also be passed in the
    /// request
    /// payload.
    ///
    /// For X-Ray traces, all Amazon Web Services services use the `X-Amzn-Trace-Id`
    /// header from the HTTP request. Using the header is the preferred mechanism to
    /// identify a trace. `StartExecution` and `StartSyncExecution` API operations
    /// can also use `traceHeader` from the body of the request payload. If **both**
    /// sources are provided, Step Functions will use the **header value**
    /// (preferred) over the value in the request body.
    trace_header: ?[]const u8 = null,

    pub const json_field_names = .{
        .included_data = "includedData",
        .input = "input",
        .name = "name",
        .state_machine_arn = "stateMachineArn",
        .trace_header = "traceHeader",
    };
};

pub const StartSyncExecutionOutput = struct {
    /// An object that describes workflow billing details, including billed duration
    /// and memory
    /// use.
    billing_details: ?BillingDetails = null,

    /// A more detailed explanation of the cause of the failure.
    cause: ?[]const u8 = null,

    /// The error code of the failure.
    @"error": ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) that identifies the execution.
    execution_arn: []const u8,

    /// The string that contains the JSON input data of the execution. Length
    /// constraints apply to the payload size, and are expressed as bytes in UTF-8
    /// encoding.
    input: ?[]const u8 = null,

    input_details: ?CloudWatchEventsExecutionDataDetails = null,

    /// The name of the execution.
    name: ?[]const u8 = null,

    /// The JSON output data of the execution. Length constraints apply to the
    /// payload size, and are expressed as bytes in UTF-8 encoding.
    ///
    /// This field is set only if the execution succeeds. If the execution fails,
    /// this field is
    /// null.
    output: ?[]const u8 = null,

    output_details: ?CloudWatchEventsExecutionDataDetails = null,

    /// The date the execution is started.
    start_date: i64,

    /// The Amazon Resource Name (ARN) that identifies the state machine.
    state_machine_arn: ?[]const u8 = null,

    /// The current status of the execution.
    status: SyncExecutionStatus,

    /// If the execution has already ended, the date the execution stopped.
    stop_date: i64,

    /// The X-Ray trace header that was passed to the execution.
    ///
    /// For X-Ray traces, all Amazon Web Services services use the `X-Amzn-Trace-Id`
    /// header from the HTTP request. Using the header is the preferred mechanism to
    /// identify a trace. `StartExecution` and `StartSyncExecution` API operations
    /// can also use `traceHeader` from the body of the request payload. If **both**
    /// sources are provided, Step Functions will use the **header value**
    /// (preferred) over the value in the request body.
    trace_header: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_details = "billingDetails",
        .cause = "cause",
        .@"error" = "error",
        .execution_arn = "executionArn",
        .input = "input",
        .input_details = "inputDetails",
        .name = "name",
        .output = "output",
        .output_details = "outputDetails",
        .start_date = "startDate",
        .state_machine_arn = "stateMachineArn",
        .status = "status",
        .stop_date = "stopDate",
        .trace_header = "traceHeader",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSyncExecutionInput, options: CallOptions) !StartSyncExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "states", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSyncExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("states", "SFN", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.StartSyncExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSyncExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartSyncExecutionOutput, body, allocator);
}

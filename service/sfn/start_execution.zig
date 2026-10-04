const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartExecutionInput = struct {
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

    /// Optional name of the execution. This name must be unique for your Amazon Web
    /// Services account, Region, and state machine for 90 days. For more
    /// information,
    /// see [
    /// Limits Related to State Machine
    /// Executions](https://docs.aws.amazon.com/step-functions/latest/dg/limits.html#service-limits-state-machine-executions) in the *Step Functions Developer Guide*.
    ///
    /// If you don't provide a name for the execution, Step Functions automatically
    /// generates a universally unique identifier (UUID) as the execution name.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the state machine to execute.
    ///
    /// The `stateMachineArn` parameter accepts one of the following inputs:
    ///
    /// * **An unqualified state machine ARN** – Refers to a state machine ARN that
    ///   isn't qualified with a version or alias ARN. The following is an example
    ///   of an unqualified state machine ARN.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// Step Functions doesn't associate state machine executions that you start
    /// with an unqualified ARN with a version. This is true even if that version
    /// uses the same revision that the execution used.
    ///
    /// * **A state machine version ARN** – Refers to a version ARN, which is a
    ///   combination of state machine ARN and the version number separated by a
    ///   colon (:). The following is an example of the ARN for version 10.
    ///
    /// `arn::states:::stateMachine::10`
    ///
    /// Step Functions doesn't associate executions that you start with a version
    /// ARN with any aliases that point to that version.
    ///
    /// * **A state machine alias ARN** – Refers to an alias ARN, which is a
    ///   combination of state machine ARN and the alias name separated by a colon
    ///   (:). The following is an example of the ARN for an alias named `PROD`.
    ///
    /// `arn::states:::stateMachine:`
    ///
    /// Step Functions associates executions
    /// that you start with an alias ARN with that alias and the state machine
    /// version used for
    /// that execution.
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
        .input = "input",
        .name = "name",
        .state_machine_arn = "stateMachineArn",
        .trace_header = "traceHeader",
    };
};

pub const StartExecutionOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the execution.
    execution_arn: []const u8,

    /// The date the execution is started.
    start_date: i64,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .start_date = "startDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartExecutionInput, options: CallOptions) !StartExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.StartExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(StartExecutionOutput, body, allocator);
}

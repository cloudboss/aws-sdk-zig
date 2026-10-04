const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CalculationConfiguration = @import("calculation_configuration.zig").CalculationConfiguration;
const CalculationExecutionState = @import("calculation_execution_state.zig").CalculationExecutionState;

pub const StartCalculationExecutionInput = struct {
    /// Contains configuration information for the calculation.
    calculation_configuration: ?CalculationConfiguration = null,

    /// A unique case-sensitive string used to ensure the request to create the
    /// calculation is
    /// idempotent (executes only once). If another
    /// `StartCalculationExecutionRequest` is received, the same response is
    /// returned and another calculation is not created. If a parameter has changed,
    /// an error is
    /// returned.
    ///
    /// This token is listed as not required because Amazon Web Services SDKs (for
    /// example
    /// the Amazon Web Services SDK for Java) auto-generate the token for users. If
    /// you are
    /// not using the Amazon Web Services SDK or the Amazon Web Services CLI, you
    /// must provide
    /// this token or the action will fail.
    client_request_token: ?[]const u8 = null,

    /// A string that contains the code of the calculation. Use this parameter
    /// instead of
    /// CalculationConfiguration$CodeBlock, which is deprecated.
    code_block: ?[]const u8 = null,

    /// A description of the calculation.
    description: ?[]const u8 = null,

    /// The session ID.
    session_id: []const u8,

    pub const json_field_names = .{
        .calculation_configuration = "CalculationConfiguration",
        .client_request_token = "ClientRequestToken",
        .code_block = "CodeBlock",
        .description = "Description",
        .session_id = "SessionId",
    };
};

pub const StartCalculationExecutionOutput = struct {
    /// The calculation execution UUID.
    calculation_execution_id: ?[]const u8 = null,

    /// `CREATING` - The calculation is in the process of being created.
    ///
    /// `CREATED` - The calculation has been created and is ready to run.
    ///
    /// `QUEUED` - The calculation has been queued for processing.
    ///
    /// `RUNNING` - The calculation is running.
    ///
    /// `CANCELING` - A request to cancel the calculation has been received and the
    /// system is working to stop it.
    ///
    /// `CANCELED` - The calculation is no longer running as the result of a cancel
    /// request.
    ///
    /// `COMPLETED` - The calculation has completed without error.
    ///
    /// `FAILED` - The calculation failed and is no longer running.
    state: ?CalculationExecutionState = null,

    pub const json_field_names = .{
        .calculation_execution_id = "CalculationExecutionId",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartCalculationExecutionInput, options: CallOptions) !StartCalculationExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartCalculationExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.StartCalculationExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartCalculationExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartCalculationExecutionOutput, body, allocator);
}

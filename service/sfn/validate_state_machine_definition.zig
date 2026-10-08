const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ValidateStateMachineDefinitionSeverity = @import("validate_state_machine_definition_severity.zig").ValidateStateMachineDefinitionSeverity;
const StateMachineType = @import("state_machine_type.zig").StateMachineType;
const ValidateStateMachineDefinitionDiagnostic = @import("validate_state_machine_definition_diagnostic.zig").ValidateStateMachineDefinitionDiagnostic;
const ValidateStateMachineDefinitionResultCode = @import("validate_state_machine_definition_result_code.zig").ValidateStateMachineDefinitionResultCode;

pub const ValidateStateMachineDefinitionInput = struct {
    /// The Amazon States Language definition of the state machine. For more
    /// information, see
    /// [Amazon States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html) (ASL).
    definition: []const u8,

    /// The maximum number of diagnostics that are returned per call. The default
    /// and maximum value is 100. Setting the value to 0 will also use the default
    /// of 100.
    ///
    /// If the number of diagnostics returned in the response exceeds `maxResults`,
    /// the value of the `truncated` field in the response will be set to `true`.
    max_results: ?i32 = null,

    /// Minimum level of diagnostics to return. `ERROR` returns only `ERROR`
    /// diagnostics, whereas `WARNING` returns both `WARNING` and `ERROR`
    /// diagnostics. The default is `ERROR`.
    severity: ?ValidateStateMachineDefinitionSeverity = null,

    /// The target type of state machine for this definition. The default is
    /// `STANDARD`.
    type: ?StateMachineType = null,

    pub const json_field_names = .{
        .definition = "definition",
        .max_results = "maxResults",
        .severity = "severity",
        .type = "type",
    };
};

pub const ValidateStateMachineDefinitionOutput = struct {
    /// An array of diagnostic errors and warnings found during validation of the
    /// state machine definition. Since **warnings** do not prevent deploying your
    /// workflow definition, the **result** value could be `OK` even when warning
    /// diagnostics are present in the response.
    diagnostics: ?[]const ValidateStateMachineDefinitionDiagnostic = null,

    /// The result value will be `OK` when no syntax errors are found, or
    /// `FAIL` if the workflow definition does not pass verification.
    result: ValidateStateMachineDefinitionResultCode,

    /// The result value will be `true` if the number of diagnostics found in the
    /// workflow definition exceeds `maxResults`. When all diagnostics results are
    /// returned, the value will be `false`.
    truncated: ?bool = null,

    pub const json_field_names = .{
        .diagnostics = "diagnostics",
        .result = "result",
        .truncated = "truncated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateStateMachineDefinitionInput, options: CallOptions) !ValidateStateMachineDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateStateMachineDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.ValidateStateMachineDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateStateMachineDefinitionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ValidateStateMachineDefinitionOutput, body, allocator);
}

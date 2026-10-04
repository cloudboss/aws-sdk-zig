const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const TracingConfiguration = @import("tracing_configuration.zig").TracingConfiguration;

pub const DescribeStateMachineForExecutionInput = struct {
    /// The Amazon Resource Name (ARN) of the execution you want state machine
    /// information for.
    execution_arn: []const u8,

    /// If your state machine definition is encrypted with a KMS key, callers must
    /// have `kms:Decrypt` permission to decrypt the definition. Alternatively, you
    /// can call the API with `includedData = METADATA_ONLY` to get a successful
    /// response without the encrypted definition.
    included_data: ?IncludedData = null,

    pub const json_field_names = .{
        .execution_arn = "executionArn",
        .included_data = "includedData",
    };
};

pub const DescribeStateMachineForExecutionOutput = struct {
    /// The Amazon States Language definition of the state machine. See [Amazon
    /// States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html).
    definition: []const u8,

    /// Settings to configure server-side encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// A user-defined or an auto-generated string that identifies a `Map` state.
    /// This field is returned only if the `executionArn` is a child workflow
    /// execution that was started by a Distributed Map state.
    label: ?[]const u8 = null,

    logging_configuration: ?LoggingConfiguration = null,

    /// The Amazon Resource Name (ARN) of the Map Run that started the child
    /// workflow execution. This field is returned only if the `executionArn` is a
    /// child workflow execution that was started by a Distributed Map state.
    map_run_arn: ?[]const u8 = null,

    /// The name of the state machine associated with the execution.
    name: []const u8,

    /// The revision identifier for the state machine. The first revision ID when
    /// you create the state machine is null.
    ///
    /// Use the state machine `revisionId` parameter to compare the revision of a
    /// state machine with the configuration of the state machine used for
    /// executions without performing a diff of the properties, such as `definition`
    /// and `roleArn`.
    revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role of the State Machine for the
    /// execution.
    role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the state machine associated with the
    /// execution.
    state_machine_arn: []const u8,

    /// Selects whether X-Ray tracing is enabled.
    tracing_configuration: ?TracingConfiguration = null,

    /// The date and time the state machine associated with an execution was
    /// updated. For a newly
    /// created state machine, this is the creation date.
    update_date: i64,

    /// A map of **state name** to a list of variables referenced by that state.
    /// States that do not use variable references will not be shown in the
    /// response.
    variable_references: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .definition = "definition",
        .encryption_configuration = "encryptionConfiguration",
        .label = "label",
        .logging_configuration = "loggingConfiguration",
        .map_run_arn = "mapRunArn",
        .name = "name",
        .revision_id = "revisionId",
        .role_arn = "roleArn",
        .state_machine_arn = "stateMachineArn",
        .tracing_configuration = "tracingConfiguration",
        .update_date = "updateDate",
        .variable_references = "variableReferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStateMachineForExecutionInput, options: CallOptions) !DescribeStateMachineForExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStateMachineForExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.DescribeStateMachineForExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStateMachineForExecutionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeStateMachineForExecutionOutput, body, allocator);
}

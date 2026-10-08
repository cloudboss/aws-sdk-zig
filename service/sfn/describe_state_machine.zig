const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IncludedData = @import("included_data.zig").IncludedData;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const StateMachineStatus = @import("state_machine_status.zig").StateMachineStatus;
const TracingConfiguration = @import("tracing_configuration.zig").TracingConfiguration;
const StateMachineType = @import("state_machine_type.zig").StateMachineType;

pub const DescribeStateMachineInput = struct {
    /// If your state machine definition is encrypted with a KMS key, callers must
    /// have `kms:Decrypt` permission to decrypt the definition. Alternatively, you
    /// can call the API with `includedData = METADATA_ONLY` to get a successful
    /// response without the encrypted definition.
    ///
    /// When calling a labelled ARN for an encrypted state machine, the
    /// `includedData = METADATA_ONLY` parameter will not apply because Step
    /// Functions needs to decrypt the entire state machine definition to get the
    /// Distributed Map state’s definition. In this case, the API caller needs to
    /// have `kms:Decrypt` permission.
    included_data: ?IncludedData = null,

    /// The Amazon Resource Name (ARN) of the state machine for which you want the
    /// information.
    ///
    /// If you specify a state machine version ARN, this API returns details about
    /// that version. The version ARN is a combination of state machine ARN and the
    /// version number separated by a colon (:). For example, `stateMachineARN:1`.
    state_machine_arn: []const u8,

    pub const json_field_names = .{
        .included_data = "includedData",
        .state_machine_arn = "stateMachineArn",
    };
};

pub const DescribeStateMachineOutput = struct {
    /// The date the state machine is created.
    ///
    /// For a state machine version, `creationDate` is the date the version was
    /// created.
    creation_date: i64,

    /// The Amazon States Language definition of the state machine. See [Amazon
    /// States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html).
    ///
    /// If called with `includedData = METADATA_ONLY`, the returned definition will
    /// be `{}`.
    definition: []const u8,

    /// The description of the state machine version.
    description: ?[]const u8 = null,

    /// Settings to configure server-side encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// A user-defined or an auto-generated string that identifies a `Map` state.
    /// This parameter is present only if the `stateMachineArn` specified in input
    /// is a qualified state machine ARN.
    label: ?[]const u8 = null,

    logging_configuration: ?LoggingConfiguration = null,

    /// The name of the state machine.
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
    name: []const u8,

    /// The revision identifier for the state machine.
    ///
    /// Use the `revisionId` parameter to compare between versions of a state
    /// machine
    /// configuration used for executions without performing a diff of the
    /// properties, such as
    /// `definition` and `roleArn`.
    revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used when creating this state
    /// machine. (The IAM role
    /// maintains security by granting Step Functions access to Amazon Web Services
    /// resources.)
    role_arn: []const u8,

    /// The Amazon Resource Name (ARN) that identifies the state machine.
    ///
    /// If you specified a state machine version ARN in your request, the API
    /// returns the version ARN. The version ARN is a combination of state machine
    /// ARN and the version number separated by a colon (:). For example,
    /// `stateMachineARN:1`.
    state_machine_arn: []const u8,

    /// The current status of the state machine.
    status: ?StateMachineStatus = null,

    /// Selects whether X-Ray tracing is enabled.
    tracing_configuration: ?TracingConfiguration = null,

    /// The `type` of the state machine (`STANDARD` or
    /// `EXPRESS`).
    type: StateMachineType,

    /// A map of **state name** to a list of variables referenced by that state.
    /// States that do not use variable references will not be shown in the
    /// response.
    variable_references: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .definition = "definition",
        .description = "description",
        .encryption_configuration = "encryptionConfiguration",
        .label = "label",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .revision_id = "revisionId",
        .role_arn = "roleArn",
        .state_machine_arn = "stateMachineArn",
        .status = "status",
        .tracing_configuration = "tracingConfiguration",
        .type = "type",
        .variable_references = "variableReferences",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStateMachineInput, options: CallOptions) !DescribeStateMachineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStateMachineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.DescribeStateMachine");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStateMachineOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeStateMachineOutput, body, allocator);
}

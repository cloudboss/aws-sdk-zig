const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const Tag = @import("tag.zig").Tag;
const TracingConfiguration = @import("tracing_configuration.zig").TracingConfiguration;
const StateMachineType = @import("state_machine_type.zig").StateMachineType;

pub const CreateStateMachineInput = struct {
    /// The Amazon States Language definition of the state machine. See [Amazon
    /// States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html).
    definition: []const u8,

    /// Settings to configure server-side encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Defines what execution history events are logged and where they are logged.
    ///
    /// By default, the `level` is set to `OFF`. For more information see
    /// [Log
    /// Levels](https://docs.aws.amazon.com/step-functions/latest/dg/cloudwatch-log-level.html) in the Step Functions User Guide.
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

    /// Set to `true` to publish the first version of the state machine during
    /// creation. The default is `false`.
    publish: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role to use for this state
    /// machine.
    role_arn: []const u8,

    /// Tags to be added when creating a state machine.
    ///
    /// An array of key-value pairs. For more information, see [Using
    /// Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Amazon Web Services Billing and Cost Management User
    /// Guide*, and [Controlling Access Using IAM
    /// Tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_iam-tags.html).
    ///
    /// Tags may only contain Unicode letters, digits, white space, or these
    /// symbols: `_ . : / = + - @`.
    tags: ?[]const Tag = null,

    /// Selects whether X-Ray tracing is enabled.
    tracing_configuration: ?TracingConfiguration = null,

    /// Determines whether a Standard or Express state machine is created. The
    /// default is
    /// `STANDARD`. You cannot update the `type` of a state machine once it
    /// has been created.
    type: ?StateMachineType = null,

    /// Sets description about the state machine version. You can only set the
    /// description if the `publish` parameter is set to `true`. Otherwise, if you
    /// set `versionDescription`, but `publish` to `false`, this API action throws
    /// `ValidationException`.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .definition = "definition",
        .encryption_configuration = "encryptionConfiguration",
        .logging_configuration = "loggingConfiguration",
        .name = "name",
        .publish = "publish",
        .role_arn = "roleArn",
        .tags = "tags",
        .tracing_configuration = "tracingConfiguration",
        .type = "type",
        .version_description = "versionDescription",
    };
};

pub const CreateStateMachineOutput = struct {
    /// The date the state machine is created.
    creation_date: i64,

    /// The Amazon Resource Name (ARN) that identifies the created state machine.
    state_machine_arn: []const u8,

    /// The Amazon Resource Name (ARN) that identifies the created state machine
    /// version. If you do not set the `publish` parameter to `true`, this field
    /// returns null value.
    state_machine_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .state_machine_arn = "stateMachineArn",
        .state_machine_version_arn = "stateMachineVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStateMachineInput, options: CallOptions) !CreateStateMachineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStateMachineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.CreateStateMachine");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStateMachineOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateStateMachineOutput, body, allocator);
}

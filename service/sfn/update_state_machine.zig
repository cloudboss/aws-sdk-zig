const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const TracingConfiguration = @import("tracing_configuration.zig").TracingConfiguration;

pub const UpdateStateMachineInput = struct {
    /// The Amazon States Language definition of the state machine. See [Amazon
    /// States
    /// Language](https://docs.aws.amazon.com/step-functions/latest/dg/concepts-amazon-states-language.html).
    definition: ?[]const u8 = null,

    /// Settings to configure server-side encryption.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// Use the `LoggingConfiguration` data type to set CloudWatch Logs
    /// options.
    logging_configuration: ?LoggingConfiguration = null,

    /// Specifies whether the state machine version is published. The default is
    /// `false`. To publish a version after updating the state machine, set
    /// `publish` to `true`.
    publish: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role of the state machine.
    role_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the state machine.
    state_machine_arn: []const u8,

    /// Selects whether X-Ray tracing is enabled.
    tracing_configuration: ?TracingConfiguration = null,

    /// An optional description of the state machine version to publish.
    ///
    /// You can only specify the `versionDescription` parameter if you've set
    /// `publish` to `true`.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .definition = "definition",
        .encryption_configuration = "encryptionConfiguration",
        .logging_configuration = "loggingConfiguration",
        .publish = "publish",
        .role_arn = "roleArn",
        .state_machine_arn = "stateMachineArn",
        .tracing_configuration = "tracingConfiguration",
        .version_description = "versionDescription",
    };
};

pub const UpdateStateMachineOutput = struct {
    /// The revision identifier for the updated state machine.
    revision_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the published state machine version.
    ///
    /// If the `publish` parameter isn't set to `true`, this field returns null.
    state_machine_version_arn: ?[]const u8 = null,

    /// The date and time the state machine was updated.
    update_date: i64,

    pub const json_field_names = .{
        .revision_id = "revisionId",
        .state_machine_version_arn = "stateMachineVersionArn",
        .update_date = "updateDate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStateMachineInput, options: CallOptions) !UpdateStateMachineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStateMachineInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSStepFunctions.UpdateStateMachine");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStateMachineOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateStateMachineOutput, body, allocator);
}

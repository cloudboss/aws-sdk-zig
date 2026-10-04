const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;
const DocumentHashType = @import("document_hash_type.zig").DocumentHashType;
const NotificationConfig = @import("notification_config.zig").NotificationConfig;
const Target = @import("target.zig").Target;
const Command = @import("command.zig").Command;

pub const SendCommandInput = struct {
    /// The CloudWatch alarm you want to apply to your command.
    alarm_configuration: ?AlarmConfiguration = null,

    /// Enables Amazon Web Services Systems Manager to send Run Command output to
    /// Amazon CloudWatch Logs. Run Command is a
    /// tool in Amazon Web Services Systems Manager.
    cloud_watch_output_config: ?CloudWatchOutputConfig = null,

    /// User-specified information about the command, such as a brief description of
    /// what the
    /// command should do.
    comment: ?[]const u8 = null,

    /// The Sha256 or Sha1 hash created by the system when the document was created.
    ///
    /// Sha1 hashes have been deprecated.
    document_hash: ?[]const u8 = null,

    /// Sha256 or Sha1.
    ///
    /// Sha1 hashes have been deprecated.
    document_hash_type: ?DocumentHashType = null,

    /// The name of the Amazon Web Services Systems Manager document (SSM document)
    /// to run. This can be a public document or a
    /// custom document. To run a shared document belonging to another account,
    /// specify the document
    /// Amazon Resource Name (ARN). For more information about how to use shared
    /// documents, see [Sharing SSM
    /// documents](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-using-shared.html) in the *Amazon Web Services Systems Manager User Guide*.
    ///
    /// If you specify a document name or ARN that hasn't been shared with your
    /// account, you
    /// receive an `InvalidDocument` error.
    document_name: []const u8,

    /// The SSM document version to use in the request. You can specify $DEFAULT,
    /// $LATEST, or a
    /// specific version number. If you run commands by using the Command Line
    /// Interface (Amazon Web Services CLI), then
    /// you must escape the first two options by using a backslash. If you specify a
    /// version number, then
    /// you don't need to use the backslash. For example:
    ///
    /// --document-version "\$DEFAULT"
    ///
    /// --document-version "\$LATEST"
    ///
    /// --document-version "3"
    document_version: ?[]const u8 = null,

    /// The IDs of the managed nodes where the command should run. Specifying
    /// managed node IDs is
    /// most useful when you are targeting a limited number of managed nodes, though
    /// you can specify up
    /// to 50 IDs.
    ///
    /// To target a larger number of managed nodes, or if you prefer not to list
    /// individual node
    /// IDs, we recommend using the `Targets` option instead. Using `Targets`,
    /// which accepts tag key-value pairs to identify the managed nodes to send
    /// commands to, you can a
    /// send command to tens, hundreds, or thousands of nodes at once.
    ///
    /// For more information about how to use targets, see [Run commands at
    /// scale](https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html)
    /// in the *Amazon Web Services Systems Manager User Guide*.
    instance_ids: ?[]const []const u8 = null,

    /// (Optional) The maximum number of managed nodes that are allowed to run the
    /// command at the
    /// same time. You can specify a number such as 10 or a percentage such as 10%.
    /// The default value is
    /// `50`. For more information about how to use `MaxConcurrency`, see [Using
    /// concurrency
    /// controls](https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-velocity) in the *Amazon Web Services Systems Manager User Guide*.
    max_concurrency: ?[]const u8 = null,

    /// The maximum number of errors allowed without the command failing. When the
    /// command fails one
    /// more time beyond the value of `MaxErrors`, the systems stops sending the
    /// command to
    /// additional targets. You can specify a number like 10 or a percentage like
    /// 10%. The default value
    /// is `0`. For more information about how to use `MaxErrors`, see [Using
    /// error
    /// controls](https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html#send-commands-maxerrors) in the *Amazon Web Services Systems Manager User Guide*.
    max_errors: ?[]const u8 = null,

    /// Configurations for sending notifications.
    notification_config: ?NotificationConfig = null,

    /// The name of the S3 bucket where command execution responses should be
    /// stored.
    output_s3_bucket_name: ?[]const u8 = null,

    /// The directory structure within the S3 bucket where the responses should be
    /// stored.
    output_s3_key_prefix: ?[]const u8 = null,

    /// (Deprecated) You can no longer specify this parameter. The system ignores
    /// it. Instead, Systems Manager
    /// automatically determines the Amazon Web Services Region of the S3 bucket.
    output_s3_region: ?[]const u8 = null,

    /// The required and optional parameters specified in the document being run.
    parameters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The ARN of the Identity and Access Management (IAM) service role to use to
    /// publish
    /// Amazon Simple Notification Service (Amazon SNS) notifications for Run
    /// Command commands.
    ///
    /// This role must provide the `sns:Publish` permission for your notification
    /// topic.
    /// For information about creating and using this service role, see [Monitoring
    /// Systems Manager status changes using Amazon SNS
    /// notifications](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitoring-sns-notifications.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    service_role_arn: ?[]const u8 = null,

    /// An array of search criteria that targets managed nodes using a `Key,Value`
    /// combination that you specify. Specifying targets is most useful when you
    /// want to send a command
    /// to a large number of managed nodes at once. Using `Targets`, which accepts
    /// tag
    /// key-value pairs to identify managed nodes, you can send a command to tens,
    /// hundreds, or thousands
    /// of nodes at once.
    ///
    /// To send a command to a smaller number of managed nodes, you can use the
    /// `InstanceIds` option instead.
    ///
    /// For more information about how to use targets, see [Run commands at
    /// scale](https://docs.aws.amazon.com/systems-manager/latest/userguide/send-commands-multiple.html)
    /// in the *Amazon Web Services Systems Manager User Guide*.
    targets: ?[]const Target = null,

    /// If this time is reached and the command hasn't already started running, it
    /// won't run.
    timeout_seconds: ?i32 = null,

    pub const json_field_names = .{
        .alarm_configuration = "AlarmConfiguration",
        .cloud_watch_output_config = "CloudWatchOutputConfig",
        .comment = "Comment",
        .document_hash = "DocumentHash",
        .document_hash_type = "DocumentHashType",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .instance_ids = "InstanceIds",
        .max_concurrency = "MaxConcurrency",
        .max_errors = "MaxErrors",
        .notification_config = "NotificationConfig",
        .output_s3_bucket_name = "OutputS3BucketName",
        .output_s3_key_prefix = "OutputS3KeyPrefix",
        .output_s3_region = "OutputS3Region",
        .parameters = "Parameters",
        .service_role_arn = "ServiceRoleArn",
        .targets = "Targets",
        .timeout_seconds = "TimeoutSeconds",
    };
};

pub const SendCommandOutput = struct {
    /// The request as it was received by Systems Manager. Also provides the command
    /// ID which can be used
    /// future references to this request.
    command: ?Command = null,

    pub const json_field_names = .{
        .command = "Command",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendCommandInput, options: CallOptions) !SendCommandOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendCommandInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.SendCommand");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendCommandOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SendCommandOutput, body, allocator);
}

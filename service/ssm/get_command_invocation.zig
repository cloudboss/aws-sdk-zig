const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CloudWatchOutputConfig = @import("cloud_watch_output_config.zig").CloudWatchOutputConfig;
const CommandInvocationStatus = @import("command_invocation_status.zig").CommandInvocationStatus;

pub const GetCommandInvocationInput = struct {
    /// (Required) The parent command ID of the invocation plugin.
    command_id: []const u8,

    /// (Required) The ID of the managed node targeted by the command. A *managed
    /// node* can be an Amazon Elastic Compute Cloud (Amazon EC2) instance, edge
    /// device, and on-premises server or VM
    /// in your hybrid environment that is configured for Amazon Web Services
    /// Systems Manager.
    instance_id: []const u8,

    /// The name of the step for which you want detailed results. If the document
    /// contains only one
    /// step, you can omit the name and details for that step. If the document
    /// contains more than one
    /// step, you must specify the name of the step for which you want to view
    /// details. Be sure to
    /// specify the name of the step, not the name of a plugin like
    /// `aws:RunShellScript`.
    ///
    /// To find the `PluginName`, check the document content and find the name of
    /// the
    /// step you want details for. Alternatively, use ListCommandInvocations with
    /// the
    /// `CommandId` and `Details` parameters. The `PluginName` is the
    /// `Name` attribute of the `CommandPlugin` object in the
    /// `CommandPlugins` list.
    plugin_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .command_id = "CommandId",
        .instance_id = "InstanceId",
        .plugin_name = "PluginName",
    };
};

pub const GetCommandInvocationOutput = struct {
    /// Amazon CloudWatch Logs information where Systems Manager sent the command
    /// output.
    cloud_watch_output_config: ?CloudWatchOutputConfig = null,

    /// The parent command ID of the invocation plugin.
    command_id: ?[]const u8 = null,

    /// The comment text for the command.
    comment: ?[]const u8 = null,

    /// The name of the document that was run. For example, `AWS-RunShellScript`.
    document_name: ?[]const u8 = null,

    /// The Systems Manager document (SSM document) version used in the request.
    document_version: ?[]const u8 = null,

    /// Duration since `ExecutionStartDateTime`.
    execution_elapsed_time: ?[]const u8 = null,

    /// The date and time the plugin finished running. Date and time are written in
    /// ISO 8601 format.
    /// For example, June 7, 2017 is represented as 2017-06-7. The following sample
    /// Amazon Web Services CLI command uses
    /// the `InvokedAfter` filter.
    ///
    /// `aws ssm list-commands --filters
    /// key=InvokedAfter,value=2017-06-07T00:00:00Z`
    ///
    /// If the plugin hasn't started to run, the string is empty.
    execution_end_date_time: ?[]const u8 = null,

    /// The date and time the plugin started running. Date and time are written in
    /// ISO 8601 format.
    /// For example, June 7, 2017 is represented as 2017-06-7. The following sample
    /// Amazon Web Services CLI command uses
    /// the `InvokedBefore` filter.
    ///
    /// `aws ssm list-commands --filters
    /// key=InvokedBefore,value=2017-06-07T00:00:00Z`
    ///
    /// If the plugin hasn't started to run, the string is empty.
    execution_start_date_time: ?[]const u8 = null,

    /// The ID of the managed node targeted by the command. A *managed node* can
    /// be an Amazon Elastic Compute Cloud (Amazon EC2) instance, edge device, or
    /// on-premises server or VM in your hybrid
    /// environment that is configured for Amazon Web Services Systems Manager.
    instance_id: ?[]const u8 = null,

    /// The name of the plugin, or *step name*, for which details are reported.
    /// For example, `aws:RunShellScript` is a plugin.
    plugin_name: ?[]const u8 = null,

    /// The error level response code for the plugin script. If the response code is
    /// `-1`, then the command hasn't started running on the managed node, or it
    /// wasn't
    /// received by the node.
    response_code: ?i32 = null,

    /// The first 8,000 characters written by the plugin to `stderr`. If the command
    /// hasn't finished running, then this string is empty.
    standard_error_content: ?[]const u8 = null,

    /// The URL for the complete text written by the plugin to `stderr`. If the
    /// command
    /// hasn't finished running, then this string is empty.
    standard_error_url: ?[]const u8 = null,

    /// The first 24,000 characters written by the plugin to `stdout`. If the
    /// command
    /// hasn't finished running, if `ExecutionStatus` is neither Succeeded nor
    /// Failed, then
    /// this string is empty.
    standard_output_content: ?[]const u8 = null,

    /// The URL for the complete text written by the plugin to `stdout` in Amazon
    /// Simple Storage Service (Amazon S3). If an S3 bucket wasn't specified, then
    /// this string is
    /// empty.
    standard_output_url: ?[]const u8 = null,

    /// The status of this invocation plugin. This status can be different than
    /// `StatusDetails`.
    status: ?CommandInvocationStatus = null,

    /// A detailed status of the command execution for an invocation.
    /// `StatusDetails`
    /// includes more information than `Status` because it includes states resulting
    /// from
    /// error and concurrency control parameters. `StatusDetails` can show different
    /// results
    /// than `Status`. For more information about these statuses, see [Understanding
    /// command
    /// statuses](https://docs.aws.amazon.com/systems-manager/latest/userguide/monitor-commands.html) in the *Amazon Web Services Systems Manager User Guide*.
    /// `StatusDetails` can be one of the following values:
    ///
    /// * Pending: The command hasn't been sent to the managed node.
    ///
    /// * In Progress: The command has been sent to the managed node but hasn't
    ///   reached a terminal
    /// state.
    ///
    /// * Delayed: The system attempted to send the command to the target, but the
    ///   target wasn't
    /// available. The managed node might not be available because of network
    /// issues, because the node
    /// was stopped, or for similar reasons. The system will try to send the command
    /// again.
    ///
    /// * Success: The command or plugin ran successfully. This is a terminal state.
    ///
    /// * Delivery Timed Out: The command wasn't delivered to the managed node
    ///   before the delivery
    /// timeout expired. Delivery timeouts don't count against the parent command's
    /// `MaxErrors` limit, but they do contribute to whether the parent command
    /// status is
    /// Success or Incomplete. This is a terminal state.
    ///
    /// * Execution Timed Out: The command started to run on the managed node, but
    ///   the execution
    /// wasn't complete before the timeout expired. Execution timeouts count against
    /// the
    /// `MaxErrors` limit of the parent command. This is a terminal state.
    ///
    /// * Failed: The command wasn't run successfully on the managed node. For a
    ///   plugin, this
    /// indicates that the result code wasn't zero. For a command invocation, this
    /// indicates that the
    /// result code for one or more plugins wasn't zero. Invocation failures count
    /// against the
    /// `MaxErrors` limit of the parent command. This is a terminal state.
    ///
    /// * Cancelled: The command was terminated before it was completed. This is a
    ///   terminal
    /// state.
    ///
    /// * Undeliverable: The command can't be delivered to the managed node. The
    ///   node might not
    /// exist or might not be responding. Undeliverable invocations don't count
    /// against the parent
    /// command's `MaxErrors` limit and don't contribute to whether the parent
    /// command
    /// status is Success or Incomplete. This is a terminal state.
    ///
    /// * Terminated: The parent command exceeded its `MaxErrors` limit and
    ///   subsequent
    /// command invocations were canceled by the system. This is a terminal state.
    status_details: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_output_config = "CloudWatchOutputConfig",
        .command_id = "CommandId",
        .comment = "Comment",
        .document_name = "DocumentName",
        .document_version = "DocumentVersion",
        .execution_elapsed_time = "ExecutionElapsedTime",
        .execution_end_date_time = "ExecutionEndDateTime",
        .execution_start_date_time = "ExecutionStartDateTime",
        .instance_id = "InstanceId",
        .plugin_name = "PluginName",
        .response_code = "ResponseCode",
        .standard_error_content = "StandardErrorContent",
        .standard_error_url = "StandardErrorUrl",
        .standard_output_content = "StandardOutputContent",
        .standard_output_url = "StandardOutputUrl",
        .status = "Status",
        .status_details = "StatusDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCommandInvocationInput, options: CallOptions) !GetCommandInvocationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCommandInvocationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetCommandInvocation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCommandInvocationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCommandInvocationOutput, body, allocator);
}

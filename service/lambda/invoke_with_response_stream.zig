const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ResponseStreamingInvocationType = @import("response_streaming_invocation_type.zig").ResponseStreamingInvocationType;
const LogType = @import("log_type.zig").LogType;
const InvokeWithResponseStreamResponseEvent = @import("invoke_with_response_stream_response_event.zig").InvokeWithResponseStreamResponseEvent;

pub const InvokeWithResponseStreamInput = struct {
    /// Up to 3,583 bytes of base64-encoded data about the invoking client to pass
    /// to the function in the context object.
    client_context: ?[]const u8 = null,

    /// The name or ARN of the Lambda function. **Name formats**
    ///
    /// * **Function name** – `my-function`.
    /// * **Function ARN** –
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** – `123456789012:function:my-function`.
    ///
    /// The length constraint applies only to the full ARN. If you specify only the
    /// function name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// Use one of the following options:
    ///
    /// * `RequestResponse` (default) – Invoke the function synchronously. Keep the
    ///   connection open until the function returns a response or times out. The
    ///   API operation response includes the function response and additional data.
    /// * `DryRun` – Validate parameter values and verify that the IAM user or role
    ///   has permission to invoke the function.
    invocation_type: ?ResponseStreamingInvocationType = null,

    /// Set to `Tail` to include the execution log in the response. Applies to
    /// synchronously invoked functions only.
    log_type: ?LogType = null,

    /// The JSON that you want to provide to your Lambda function as input.
    ///
    /// You can enter the JSON directly. For example, `--payload '{ "key": "value"
    /// }'`. You can also specify a file path. For example, `--payload
    /// file://payload.json`.
    payload: ?[]const u8 = null,

    /// The alias name.
    qualifier: ?[]const u8 = null,

    /// The identifier of the tenant in a multi-tenant Lambda function.
    tenant_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_context = "ClientContext",
        .function_name = "FunctionName",
        .invocation_type = "InvocationType",
        .log_type = "LogType",
        .payload = "Payload",
        .qualifier = "Qualifier",
        .tenant_id = "TenantId",
    };
};

pub const InvokeWithResponseStreamOutput = struct {
    /// The stream of response payloads.
    event_stream: ?InvokeWithResponseStreamResponseEvent = null,

    /// The version of the function that executed. When you invoke a function with
    /// an alias, this indicates which version the alias resolved to.
    executed_version: ?[]const u8 = null,

    /// The type of data the stream is returning.
    response_stream_content_type: ?[]const u8 = null,

    /// For a successful request, the HTTP status code is in the 200 range. For the
    /// `RequestResponse` invocation type, this status code is 200. For the `DryRun`
    /// invocation type, this status code is 204.
    status_code: ?i32 = null,

    pub const json_field_names = .{
        .event_stream = "EventStream",
        .executed_version = "ExecutedVersion",
        .response_stream_content_type = "ResponseStreamContentType",
        .status_code = "StatusCode",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InvokeWithResponseStreamInput, options: Options) !InvokeWithResponseStreamOutput {
    _ = client;
    _ = allocator;
    _ = input;
    _ = options;
    return error.EventStreamNotSupported;
}

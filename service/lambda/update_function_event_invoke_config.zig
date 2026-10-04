const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationConfig = @import("destination_config.zig").DestinationConfig;

pub const UpdateFunctionEventInvokeConfigInput = struct {
    /// A destination for events after they have been sent to a function for
    /// processing. **Destinations**
    ///
    /// * **Function** - The Amazon Resource Name (ARN) of a Lambda function.
    /// * **Queue** - The ARN of a standard SQS queue.
    /// * **Bucket** - The ARN of an Amazon S3 bucket.
    /// * **Topic** - The ARN of a standard SNS topic.
    /// * **Event Bus** - The ARN of an Amazon EventBridge event bus.
    ///
    /// S3 buckets are supported only for on-failure destinations. To retain records
    /// of successful invocations, use another destination type.
    destination_config: ?DestinationConfig = null,

    /// The name or ARN of the Lambda function, version, or alias. **Name formats**
    ///
    /// * **Function name** - `my-function` (name-only), `my-function:v1` (with
    ///   alias).
    /// * **Function ARN** -
    ///   `arn:aws:lambda:us-west-2:123456789012:function:my-function`.
    /// * **Partial ARN** - `123456789012:function:my-function`.
    ///
    /// You can append a version number or alias to any of the formats. The length
    /// constraint applies only to the full ARN. If you specify only the function
    /// name, it is limited to 64 characters in length.
    function_name: []const u8,

    /// The maximum age of a request that Lambda sends to a function for processing.
    maximum_event_age_in_seconds: ?i32 = null,

    /// The maximum number of times to retry when the function returns an error.
    maximum_retry_attempts: ?i32 = null,

    /// A version number or alias name.
    qualifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_config = "DestinationConfig",
        .function_name = "FunctionName",
        .maximum_event_age_in_seconds = "MaximumEventAgeInSeconds",
        .maximum_retry_attempts = "MaximumRetryAttempts",
        .qualifier = "Qualifier",
    };
};

pub const UpdateFunctionEventInvokeConfigOutput = @import("function_event_invoke_config.zig").FunctionEventInvokeConfig;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFunctionEventInvokeConfigInput, options: CallOptions) !UpdateFunctionEventInvokeConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFunctionEventInvokeConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2019-09-25/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/event-invoke-config");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.qualifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "Qualifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.destination_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_event_age_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumEventAgeInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_retry_attempts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumRetryAttempts\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFunctionEventInvokeConfigOutput {
    var result: UpdateFunctionEventInvokeConfigOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFunctionEventInvokeConfigOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

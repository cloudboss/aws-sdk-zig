const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OperationStatus = @import("operation_status.zig").OperationStatus;
const HandlerErrorCode = @import("handler_error_code.zig").HandlerErrorCode;

pub const RecordHandlerProgressInput = struct {
    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    bearer_token: []const u8,

    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    client_request_token: ?[]const u8 = null,

    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    current_operation_status: ?OperationStatus = null,

    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    error_code: ?HandlerErrorCode = null,

    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    operation_status: OperationStatus,

    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    resource_model: ?[]const u8 = null,

    /// Reserved for use by the [CloudFormation
    /// CLI](https://docs.aws.amazon.com/cloudformation-cli/latest/userguide/what-is-cloudformation-cli.html).
    status_message: ?[]const u8 = null,
};

pub const RecordHandlerProgressOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RecordHandlerProgressInput, options: CallOptions) !RecordHandlerProgressOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RecordHandlerProgressInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudformation", "CloudFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=RecordHandlerProgress&Version=2010-05-15");
    try body_buf.appendSlice(allocator, "&BearerToken=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.bearer_token);
    if (input.client_request_token) |v| {
        try body_buf.appendSlice(allocator, "&ClientRequestToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.current_operation_status) |v| {
        try body_buf.appendSlice(allocator, "&CurrentOperationStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.error_code) |v| {
        try body_buf.appendSlice(allocator, "&ErrorCode=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&OperationStatus=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.operation_status.wireName());
    if (input.resource_model) |v| {
        try body_buf.appendSlice(allocator, "&ResourceModel=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.status_message) |v| {
        try body_buf.appendSlice(allocator, "&StatusMessage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RecordHandlerProgressOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: RecordHandlerProgressOutput = .{};

    return result;
}

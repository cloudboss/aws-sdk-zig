const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisionedConcurrencyStatusEnum = @import("provisioned_concurrency_status_enum.zig").ProvisionedConcurrencyStatusEnum;

pub const GetProvisionedConcurrencyConfigInput = struct {
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

    /// The version number or alias name.
    qualifier: []const u8,

    pub const json_field_names = .{
        .function_name = "FunctionName",
        .qualifier = "Qualifier",
    };
};

pub const GetProvisionedConcurrencyConfigOutput = struct {
    /// The amount of provisioned concurrency allocated. When a weighted alias is
    /// used during linear and canary deployments, this value fluctuates depending
    /// on the amount of concurrency that is provisioned for the function versions.
    allocated_provisioned_concurrent_executions: ?i32 = null,

    /// The amount of provisioned concurrency available.
    available_provisioned_concurrent_executions: ?i32 = null,

    /// The date and time that a user last updated the configuration, in [ISO 8601
    /// format](https://www.iso.org/iso-8601-date-and-time-format.html).
    last_modified: ?[]const u8 = null,

    /// The amount of provisioned concurrency requested.
    requested_provisioned_concurrent_executions: ?i32 = null,

    /// The status of the allocation process.
    status: ?ProvisionedConcurrencyStatusEnum = null,

    /// For failed allocations, the reason that provisioned concurrency could not be
    /// allocated.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .allocated_provisioned_concurrent_executions = "AllocatedProvisionedConcurrentExecutions",
        .available_provisioned_concurrent_executions = "AvailableProvisionedConcurrentExecutions",
        .last_modified = "LastModified",
        .requested_provisioned_concurrent_executions = "RequestedProvisionedConcurrentExecutions",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProvisionedConcurrencyConfigInput, options: CallOptions) !GetProvisionedConcurrencyConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProvisionedConcurrencyConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2019-09-30/functions/");
    try path_buf.appendSlice(allocator, input.function_name);
    try path_buf.appendSlice(allocator, "/provisioned-concurrency");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "Qualifier=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.qualifier);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProvisionedConcurrencyConfigOutput {
    const result: GetProvisionedConcurrencyConfigOutput = try aws.json.parseJsonObject(
        GetProvisionedConcurrencyConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

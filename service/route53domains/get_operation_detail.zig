const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OperationStatus = @import("operation_status.zig").OperationStatus;
const StatusFlag = @import("status_flag.zig").StatusFlag;
const OperationType = @import("operation_type.zig").OperationType;

pub const GetOperationDetailInput = struct {
    /// The identifier for the operation for which you want to get the status. Route
    /// 53
    /// returned the identifier in the response to the original request.
    operation_id: []const u8,

    pub const json_field_names = .{
        .operation_id = "OperationId",
    };
};

pub const GetOperationDetailOutput = struct {
    /// The name of a domain.
    domain_name: ?[]const u8 = null,

    /// The date when the operation was last updated.
    last_updated_date: ?i64 = null,

    /// Detailed information on the status including possible errors.
    message: ?[]const u8 = null,

    /// The identifier for the operation.
    operation_id: ?[]const u8 = null,

    /// The current status of the requested operation in the system.
    status: ?OperationStatus = null,

    /// Lists any outstanding operations that require customer action. Valid values
    /// are:
    ///
    /// * `PENDING_ACCEPTANCE`: The operation is waiting for acceptance from
    /// the account that is receiving the domain.
    ///
    /// * `PENDING_CUSTOMER_ACTION`: The operation is waiting for customer
    /// action, for example, returning an email.
    ///
    /// * `PENDING_AUTHORIZATION`: The operation is waiting for the form of
    /// authorization. For more information, see
    /// [ResendOperationAuthorization](https://docs.aws.amazon.com/Route53/latest/APIReference/API_domains_ResendOperationAuthorization.html).
    ///
    /// * `PENDING_PAYMENT_VERIFICATION`: The operation is waiting for the
    /// payment method to validate.
    ///
    /// * `PENDING_SUPPORT_CASE`: The operation includes a support case and
    /// is waiting for its resolution.
    status_flag: ?StatusFlag = null,

    /// The date when the request was submitted.
    submitted_date: ?i64 = null,

    /// The type of operation that was requested.
    @"type": ?OperationType = null,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .last_updated_date = "LastUpdatedDate",
        .message = "Message",
        .operation_id = "OperationId",
        .status = "Status",
        .status_flag = "StatusFlag",
        .submitted_date = "SubmittedDate",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOperationDetailInput, options: CallOptions) !GetOperationDetailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53domains", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOperationDetailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53domains", "Route 53 Domains", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Domains_v20140515.GetOperationDetail");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOperationDetailOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetOperationDetailOutput, body, allocator);
}

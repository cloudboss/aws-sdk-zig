const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegisteredCustomerManagedKey = @import("registered_customer_managed_key.zig").RegisteredCustomerManagedKey;
const QDataKey = @import("q_data_key.zig").QDataKey;

pub const DescribeKeyRegistrationInput = struct {
    /// The ID of the Amazon Web Services account that contains the customer managed
    /// key registration that you want to describe.
    aws_account_id: []const u8,

    /// Determines whether the request returns the default key only.
    default_key_only: ?bool = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .default_key_only = "DefaultKeyOnly",
    };
};

pub const DescribeKeyRegistrationOutput = struct {
    /// The ID of the Amazon Web Services account that contains the customer managed
    /// key registration specified in the request.
    aws_account_id: ?[]const u8 = null,

    /// A list of `RegisteredCustomerManagedKey` objects in a Quick Sight account.
    key_registration: ?[]const RegisteredCustomerManagedKey = null,

    /// A list of `QDataKey` objects in a Quick Sight account.
    q_data_key: ?QDataKey = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .key_registration = "KeyRegistration",
        .q_data_key = "QDataKey",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeKeyRegistrationInput, options: CallOptions) !DescribeKeyRegistrationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeKeyRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/key-registration");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.default_key_only) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "default-key-only=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeKeyRegistrationOutput {
    const result: DescribeKeyRegistrationOutput = try aws.json.parseJsonObject(
        DescribeKeyRegistrationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

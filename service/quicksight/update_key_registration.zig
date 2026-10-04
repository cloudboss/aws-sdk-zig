const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RegisteredCustomerManagedKey = @import("registered_customer_managed_key.zig").RegisteredCustomerManagedKey;
const FailedKeyRegistrationEntry = @import("failed_key_registration_entry.zig").FailedKeyRegistrationEntry;
const SuccessfulKeyRegistrationEntry = @import("successful_key_registration_entry.zig").SuccessfulKeyRegistrationEntry;

pub const UpdateKeyRegistrationInput = struct {
    /// The ID of the Amazon Web Services account that contains the customer managed
    /// key registration that you want to update.
    aws_account_id: []const u8,

    /// A list of `RegisteredCustomerManagedKey` objects to be updated to the Quick
    /// Sight account.
    key_registration: []const RegisteredCustomerManagedKey,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .key_registration = "KeyRegistration",
    };
};

pub const UpdateKeyRegistrationOutput = struct {
    /// A list of all customer managed key registrations that failed to update.
    failed_key_registration: ?[]const FailedKeyRegistrationEntry = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// A list of all customer managed key registrations that were successfully
    /// updated.
    successful_key_registration: ?[]const SuccessfulKeyRegistrationEntry = null,

    pub const json_field_names = .{
        .failed_key_registration = "FailedKeyRegistration",
        .request_id = "RequestId",
        .successful_key_registration = "SuccessfulKeyRegistration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateKeyRegistrationInput, options: CallOptions) !UpdateKeyRegistrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateKeyRegistrationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/key-registration");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"KeyRegistration\":");
    try aws.json.writeValue(@TypeOf(input.key_registration), input.key_registration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateKeyRegistrationOutput {
    var result: UpdateKeyRegistrationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateKeyRegistrationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

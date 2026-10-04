const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoTransferBillingGroupCreationPreference = @import("auto_transfer_billing_group_creation_preference.zig").AutoTransferBillingGroupCreationPreference;

pub const GetBillingTransferPreferenceInput = struct {
    /// The Amazon Resource Name (ARN) of the billing transfer whose preference you
    /// want to retrieve.
    responsibility_transfer_arn: []const u8,

    pub const json_field_names = .{
        .responsibility_transfer_arn = "ResponsibilityTransferArn",
    };
};

pub const GetBillingTransferPreferenceOutput = struct {
    /// The auto billing group creation preference for the billing transfer.
    auto_billing_transfer_billing_group_creation: ?AutoTransferBillingGroupCreationPreference = null,

    /// The most recent time when the preference was modified. This value is empty
    /// if the preference has never been set for the billing transfer.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the billing transfer that the preference
    /// applies to.
    responsibility_transfer_arn: []const u8,

    pub const json_field_names = .{
        .auto_billing_transfer_billing_group_creation = "AutoBillingTransferBillingGroupCreation",
        .last_modified_time = "LastModifiedTime",
        .responsibility_transfer_arn = "ResponsibilityTransferArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBillingTransferPreferenceInput, options: CallOptions) !GetBillingTransferPreferenceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "billingconductor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBillingTransferPreferenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-billing-transfer-preference";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResponsibilityTransferArn\":");
    try aws.json.writeValue(@TypeOf(input.responsibility_transfer_arn), input.responsibility_transfer_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBillingTransferPreferenceOutput {
    const result: GetBillingTransferPreferenceOutput = try aws.json.parseJsonObject(
        GetBillingTransferPreferenceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

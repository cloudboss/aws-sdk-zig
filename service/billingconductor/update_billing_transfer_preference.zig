const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoTransferBillingGroupCreationPreference = @import("auto_transfer_billing_group_creation_preference.zig").AutoTransferBillingGroupCreationPreference;

pub const UpdateBillingTransferPreferenceInput = struct {
    /// The auto billing group creation preference to set for the billing transfer.
    auto_billing_transfer_billing_group_creation: AutoTransferBillingGroupCreationPreference,

    /// A unique, case-sensitive identifier that you specify to ensure idempotency
    /// of the request. Idempotency ensures that an API request completes no more
    /// than one time. With an idempotent request, if the original request completes
    /// successfully, any subsequent retries complete successfully without
    /// performing any further actions.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the billing transfer whose preference you
    /// want to set.
    responsibility_transfer_arn: []const u8,

    pub const json_field_names = .{
        .auto_billing_transfer_billing_group_creation = "AutoBillingTransferBillingGroupCreation",
        .client_token = "ClientToken",
        .responsibility_transfer_arn = "ResponsibilityTransferArn",
    };
};

pub const UpdateBillingTransferPreferenceOutput = struct {
    /// The updated auto billing group creation preference for the billing transfer.
    auto_billing_transfer_billing_group_creation: ?AutoTransferBillingGroupCreationPreference = null,

    /// The most recent time when the preference was modified.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateBillingTransferPreferenceInput, options: CallOptions) !UpdateBillingTransferPreferenceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateBillingTransferPreferenceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/update-billing-transfer-preference";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AutoBillingTransferBillingGroupCreation\":");
    try aws.json.writeValue(@TypeOf(input.auto_billing_transfer_billing_group_creation), input.auto_billing_transfer_billing_group_creation, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ResponsibilityTransferArn\":");
    try aws.json.writeValue(@TypeOf(input.responsibility_transfer_arn), input.responsibility_transfer_arn, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateBillingTransferPreferenceOutput {
    const result: UpdateBillingTransferPreferenceOutput = try aws.json.parseJsonObject(
        UpdateBillingTransferPreferenceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

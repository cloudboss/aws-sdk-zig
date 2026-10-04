const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountGrouping = @import("account_grouping.zig").AccountGrouping;
const ComputationPreference = @import("computation_preference.zig").ComputationPreference;

pub const CreateBillingGroupInput = struct {
    /// The set of accounts that will be under the billing group. The set of
    /// accounts resemble the linked accounts in a consolidated billing family.
    account_grouping: AccountGrouping,

    /// A unique, case-sensitive identifier that you specify to ensure idempotency
    /// of the request. Idempotency ensures that an API request completes no more
    /// than one time. With an idempotent request, if the original request completes
    /// successfully, any subsequent retries complete successfully without
    /// performing any further actions.
    client_token: ?[]const u8 = null,

    /// The preferences and settings that will be used to compute the Amazon Web
    /// Services charges for a billing group.
    computation_preference: ComputationPreference,

    /// The description of the billing group.
    description: ?[]const u8 = null,

    /// The billing group name. The names must be unique.
    name: []const u8,

    /// The account ID that serves as the main account in a billing group.
    primary_account_id: ?[]const u8 = null,

    /// A map that contains tag keys and tag values that are attached to a billing
    /// group. This feature isn't available during the beta.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .account_grouping = "AccountGrouping",
        .client_token = "ClientToken",
        .computation_preference = "ComputationPreference",
        .description = "Description",
        .name = "Name",
        .primary_account_id = "PrimaryAccountId",
        .tags = "Tags",
    };
};

pub const CreateBillingGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the created billing group.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBillingGroupInput, options: CallOptions) !CreateBillingGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBillingGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("billingconductor", "billingconductor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/create-billing-group";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountGrouping\":");
    try aws.json.writeValue(@TypeOf(input.account_grouping), input.account_grouping, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ComputationPreference\":");
    try aws.json.writeValue(@TypeOf(input.computation_preference), input.computation_preference, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.primary_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PrimaryAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(allocator, "X-Amzn-Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBillingGroupOutput {
    const result: CreateBillingGroupOutput = try aws.json.parseJsonObject(
        CreateBillingGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingGroupProperties = @import("billing_group_properties.zig").BillingGroupProperties;
const Tag = @import("tag.zig").Tag;

pub const CreateBillingGroupInput = struct {
    /// The name you wish to give to the billing group.
    billing_group_name: []const u8,

    /// The properties of the billing group.
    billing_group_properties: ?BillingGroupProperties = null,

    /// Metadata which can be used to manage the billing group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .billing_group_name = "billingGroupName",
        .billing_group_properties = "billingGroupProperties",
        .tags = "tags",
    };
};

pub const CreateBillingGroupOutput = struct {
    /// The ARN of the billing group.
    billing_group_arn: ?[]const u8 = null,

    /// The ID of the billing group.
    billing_group_id: ?[]const u8 = null,

    /// The name you gave to the billing group.
    billing_group_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .billing_group_arn = "billingGroupArn",
        .billing_group_id = "billingGroupId",
        .billing_group_name = "billingGroupName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBillingGroupInput, options: CallOptions) !CreateBillingGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/billing-groups/");
    try path_buf.appendSlice(allocator, input.billing_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.billing_group_properties) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"billingGroupProperties\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBillingGroupOutput {
    var result: CreateBillingGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBillingGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

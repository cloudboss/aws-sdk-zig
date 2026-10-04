const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateEncryption = @import("update_encryption.zig").UpdateEncryption;
const EntitlementStatus = @import("entitlement_status.zig").EntitlementStatus;
const Entitlement = @import("entitlement.zig").Entitlement;

pub const UpdateFlowEntitlementInput = struct {
    /// A description of the entitlement. This description appears only on the
    /// MediaConnect console and will not be seen by the subscriber or end user.
    description: ?[]const u8 = null,

    /// The type of encryption that will be used on the output associated with this
    /// entitlement. Allowable encryption types: static-key, speke.
    encryption: ?UpdateEncryption = null,

    /// The Amazon Resource Name (ARN) of the entitlement that you want to update.
    entitlement_arn: []const u8,

    /// An indication of whether you want to enable the entitlement to allow access,
    /// or disable it to stop streaming content to the subscriber’s flow
    /// temporarily. If you don’t specify the `entitlementStatus` field in your
    /// request, MediaConnect leaves the value unchanged.
    entitlement_status: ?EntitlementStatus = null,

    /// The ARN of the flow that is associated with the entitlement that you want to
    /// update.
    flow_arn: []const u8,

    /// The Amazon Web Services account IDs that you want to share your content
    /// with. The receiving accounts (subscribers) will be allowed to create their
    /// own flow using your content as the source.
    subscribers: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .encryption = "Encryption",
        .entitlement_arn = "EntitlementArn",
        .entitlement_status = "EntitlementStatus",
        .flow_arn = "FlowArn",
        .subscribers = "Subscribers",
    };
};

pub const UpdateFlowEntitlementOutput = struct {
    /// The new configuration of the entitlement that you updated.
    entitlement: ?Entitlement = null,

    /// The ARN of the flow that this entitlement was granted on.
    flow_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .entitlement = "Entitlement",
        .flow_arn = "FlowArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFlowEntitlementInput, options: CallOptions) !UpdateFlowEntitlementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFlowEntitlementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/entitlements/");
    try path_buf.appendSlice(allocator, input.entitlement_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Encryption\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.entitlement_status) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EntitlementStatus\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.subscribers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Subscribers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFlowEntitlementOutput {
    const result: UpdateFlowEntitlementOutput = try aws.json.parseJsonObject(
        UpdateFlowEntitlementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

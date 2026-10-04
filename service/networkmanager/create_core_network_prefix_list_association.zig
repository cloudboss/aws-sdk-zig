const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateCoreNetworkPrefixListAssociationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the core network to associate with the prefix list.
    core_network_id: []const u8,

    /// An optional alias for the prefix list association.
    prefix_list_alias: []const u8,

    /// The ARN of the prefix list to associate with the core network.
    prefix_list_arn: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .core_network_id = "CoreNetworkId",
        .prefix_list_alias = "PrefixListAlias",
        .prefix_list_arn = "PrefixListArn",
    };
};

pub const CreateCoreNetworkPrefixListAssociationOutput = struct {
    /// The ID of the core network associated with the prefix list.
    core_network_id: ?[]const u8 = null,

    /// The alias of the prefix list association, if provided.
    prefix_list_alias: ?[]const u8 = null,

    /// The ARN of the prefix list that was associated with the core network.
    prefix_list_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .core_network_id = "CoreNetworkId",
        .prefix_list_alias = "PrefixListAlias",
        .prefix_list_arn = "PrefixListArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCoreNetworkPrefixListAssociationInput, options: CallOptions) !CreateCoreNetworkPrefixListAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "networkmanager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCoreNetworkPrefixListAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkmanager", "NetworkManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/prefix-list";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CoreNetworkId\":");
    try aws.json.writeValue(@TypeOf(input.core_network_id), input.core_network_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PrefixListAlias\":");
    try aws.json.writeValue(@TypeOf(input.prefix_list_alias), input.prefix_list_alias, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PrefixListArn\":");
    try aws.json.writeValue(@TypeOf(input.prefix_list_arn), input.prefix_list_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCoreNetworkPrefixListAssociationOutput {
    const result: CreateCoreNetworkPrefixListAssociationOutput = try aws.json.parseJsonObject(
        CreateCoreNetworkPrefixListAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

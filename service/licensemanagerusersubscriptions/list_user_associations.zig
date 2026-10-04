const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const IdentityProvider = @import("identity_provider.zig").IdentityProvider;
const InstanceUserSummary = @import("instance_user_summary.zig").InstanceUserSummary;

pub const ListUserAssociationsInput = struct {
    /// You can use the following filters to streamline results:
    ///
    /// * Status
    /// * Username
    /// * Domain
    filters: ?[]const Filter = null,

    /// An object that specifies details for the identity provider.
    identity_provider: IdentityProvider,

    /// The ID of the EC2 instance, which provides user-based subscriptions.
    instance_id: []const u8,

    /// The maximum number of results to return from a single request.
    max_results: ?i32 = null,

    /// A token to specify where to start paginating. This is the nextToken from a
    /// previously truncated response.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .identity_provider = "IdentityProvider",
        .instance_id = "InstanceId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListUserAssociationsOutput = struct {
    /// Metadata that describes the list user association operation.
    instance_user_summaries: ?[]const InstanceUserSummary = null,

    /// The next token used for paginated responses. When this field isn't empty,
    /// there are additional elements that the service hasn't included in this
    /// request. Use this token with the next request to retrieve additional
    /// objects.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_user_summaries = "InstanceUserSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUserAssociationsInput, options: CallOptions) !ListUserAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager-user-subscriptions", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUserAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager-user-subscriptions", "License Manager User Subscriptions", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/user/ListUserAssociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"IdentityProvider\":");
    try aws.json.writeValue(@TypeOf(input.identity_provider), input.identity_provider, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUserAssociationsOutput {
    const result: ListUserAssociationsOutput = try aws.json.parseJsonObject(
        ListUserAssociationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

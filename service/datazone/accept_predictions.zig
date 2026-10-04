const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcceptChoice = @import("accept_choice.zig").AcceptChoice;
const AcceptRule = @import("accept_rule.zig").AcceptRule;

pub const AcceptPredictionsInput = struct {
    /// Specifies the prediction (aka, the automatically generated piece of
    /// metadata) and the target (for example, a column name) that can be accepted.
    accept_choices: ?[]const AcceptChoice = null,

    /// Specifies the rule (or the conditions) under which a prediction can be
    /// accepted.
    accept_rule: ?AcceptRule = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    /// This field is automatically populated if not provided.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain.
    domain_identifier: []const u8,

    /// The identifier of the asset.
    identifier: []const u8,

    /// The revision that is to be made to the asset.
    revision: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_choices = "acceptChoices",
        .accept_rule = "acceptRule",
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
        .revision = "revision",
    };
};

pub const AcceptPredictionsOutput = struct {
    /// The ID of the asset.
    asset_id: []const u8,

    /// The identifier of the Amazon DataZone domain.
    domain_id: []const u8,

    /// The revision that is to be made to the asset.
    revision: []const u8,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .domain_id = "domainId",
        .revision = "revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AcceptPredictionsInput, options: CallOptions) !AcceptPredictionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AcceptPredictionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/accept-predictions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.revision) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "revision=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.accept_choices) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"acceptChoices\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.accept_rule) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"acceptRule\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AcceptPredictionsOutput {
    const result: AcceptPredictionsOutput = try aws.json.parseJsonObject(
        AcceptPredictionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

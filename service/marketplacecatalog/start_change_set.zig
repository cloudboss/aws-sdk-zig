const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Change = @import("change.zig").Change;
const Tag = @import("tag.zig").Tag;
const Intent = @import("intent.zig").Intent;

pub const StartChangeSetInput = struct {
    /// The catalog related to the request. Fixed value: `AWSMarketplace`
    catalog: []const u8,

    /// Array of `change` object.
    change_set: []const Change,

    /// Optional case sensitive string of up to 100 ASCII characters. The change set
    /// name can
    /// be used to filter the list of change sets.
    change_set_name: ?[]const u8 = null,

    /// A list of objects specifying each key name and value for the
    /// `ChangeSetTags` property.
    change_set_tags: ?[]const Tag = null,

    /// A unique token to identify the request to ensure idempotency.
    client_request_token: ?[]const u8 = null,

    /// The intent related to the request. The default is `APPLY`.
    /// To test your request before applying changes to your entities, use
    /// `VALIDATE`.
    /// This feature is currently available for adding versions to single-AMI
    /// products. For more information, see
    /// [Add a new
    /// version](https://docs.aws.amazon.com/marketplace-catalog/latest/api-reference/ami-products.html#ami-add-version).
    intent: ?Intent = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .change_set = "ChangeSet",
        .change_set_name = "ChangeSetName",
        .change_set_tags = "ChangeSetTags",
        .client_request_token = "ClientRequestToken",
        .intent = "Intent",
    };
};

pub const StartChangeSetOutput = struct {
    /// The ARN associated to the unique identifier generated for the request.
    change_set_arn: ?[]const u8 = null,

    /// Unique identifier generated for the request.
    change_set_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_set_arn = "ChangeSetArn",
        .change_set_id = "ChangeSetId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartChangeSetInput, options: CallOptions) !StartChangeSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aws-marketplace", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartChangeSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("catalog.marketplace", "Marketplace Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartChangeSet";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Catalog\":");
    try aws.json.writeValue(@TypeOf(input.catalog), input.catalog, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChangeSet\":");
    try aws.json.writeValue(@TypeOf(input.change_set), input.change_set, allocator, &body_buf);
    has_prev = true;
    if (input.change_set_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChangeSetName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.change_set_tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChangeSetTags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.intent) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Intent\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartChangeSetOutput {
    var result: StartChangeSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartChangeSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateOutput = @import("create_output.zig").CreateOutput;

pub const AssociateFeedInput = struct {
    /// An identifier for the resource. This name must not resemble an ARN.
    ///
    /// The resource is the source media that the feed will process. The name you
    /// assign should help you to later identify the source media that belongs to
    /// the feed. In this way, you will know which source media to push to the feed
    /// (using PutMedia).
    associated_resource_name: []const u8,

    /// Set to true if you want to do a dry run of the associate action.
    ///
    /// Elemental Inference will validate that the real request would succeed
    /// without actually making any changes. A dry run catches errors such as
    /// missing IAM permissions, quota limits exceeded, conflicting outputs, and so
    /// on. If the dry run fails, the action returns a 4xx error code. After you've
    /// fixed the errors, resubmit the request.
    dry_run: ?bool = null,

    /// The ID of the feed.
    id: []const u8,

    /// An array of one or more outputs that you want to add to this feed now, to
    /// supplement any outputs that you specified when you created or updated the
    /// feed.
    outputs: []const CreateOutput,

    pub const json_field_names = .{
        .associated_resource_name = "associatedResourceName",
        .dry_run = "dryRun",
        .id = "id",
        .outputs = "outputs",
    };
};

pub const AssociateFeedOutput = struct {
    /// The ARN of the feed.
    arn: []const u8,

    /// The ID of the feed.
    id: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateFeedInput, options: CallOptions) !AssociateFeedOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elemental-inference", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateFeedInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elemental-inference", "ElementalInference", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/feed/");
    try path_buf.appendSlice(allocator, input.id);
    try path_buf.appendSlice(allocator, "/associate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"associatedResourceName\":");
    try aws.json.writeValue(@TypeOf(input.associated_resource_name), input.associated_resource_name, allocator, &body_buf);
    has_prev = true;
    if (input.dry_run) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dryRun\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputs\":");
    try aws.json.writeValue(@TypeOf(input.outputs), input.outputs, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateFeedOutput {
    const result: AssociateFeedOutput = try aws.json.parseJsonObject(
        AssociateFeedOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

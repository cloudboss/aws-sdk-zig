const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetViewError = @import("batch_get_view_error.zig").BatchGetViewError;
const View = @import("view.zig").View;

pub const BatchGetViewInput = struct {
    /// A list of [Amazon resource names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) that identify the views you want details for.
    view_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .view_arns = "ViewArns",
    };
};

pub const BatchGetViewOutput = struct {
    /// If any of the specified ARNs result in an error, then this structure
    /// describes the error.
    errors: ?[]const BatchGetViewError = null,

    /// A structure with a list of objects with details for each of the specified
    /// views.
    views: ?[]const View = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .views = "Views",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetViewInput, options: CallOptions) !BatchGetViewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-explorer-2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-explorer-2", "Resource Explorer 2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchGetView";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.view_arns) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ViewArns\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetViewOutput {
    var result: BatchGetViewOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetViewOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

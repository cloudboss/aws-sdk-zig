const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateCellInput = struct {
    /// The name of the cell.
    cell_name: []const u8,

    /// A list of cell Amazon Resource Names (ARNs), which completely replaces the
    /// previous list.
    cells: []const []const u8,

    pub const json_field_names = .{
        .cell_name = "CellName",
        .cells = "Cells",
    };
};

pub const UpdateCellOutput = struct {
    /// The Amazon Resource Name (ARN) for the cell.
    cell_arn: ?[]const u8 = null,

    /// The name of the cell.
    cell_name: ?[]const u8 = null,

    /// A list of cell ARNs.
    cells: ?[]const []const u8 = null,

    /// The readiness scope for the cell, which can be a cell Amazon Resource Name
    /// (ARN) or a recovery group ARN. This is a list but currently can have only
    /// one element.
    parent_readiness_scopes: ?[]const []const u8 = null,

    /// Tags on the resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .cell_arn = "CellArn",
        .cell_name = "CellName",
        .cells = "Cells",
        .parent_readiness_scopes = "ParentReadinessScopes",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCellInput, options: CallOptions) !UpdateCellOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53-recovery-readiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCellInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53-recovery-readiness", "Route53 Recovery Readiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cells/");
    try path_buf.appendSlice(allocator, input.cell_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Cells\":");
    try aws.json.writeValue(@TypeOf(input.cells), input.cells, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCellOutput {
    var result: UpdateCellOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCellOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

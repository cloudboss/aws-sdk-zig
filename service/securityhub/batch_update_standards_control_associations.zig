const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StandardsControlAssociationUpdate = @import("standards_control_association_update.zig").StandardsControlAssociationUpdate;
const UnprocessedStandardsControlAssociationUpdate = @import("unprocessed_standards_control_association_update.zig").UnprocessedStandardsControlAssociationUpdate;

pub const BatchUpdateStandardsControlAssociationsInput = struct {
    /// Updates the enablement status of a security control in a specified standard.
    ///
    /// Calls to this operation return a `RESOURCE_NOT_FOUND_EXCEPTION` error when
    /// the standard subscription for the control has `StandardsControlsUpdatable`
    /// value `NOT_READY_FOR_UPDATES`.
    standards_control_association_updates: []const StandardsControlAssociationUpdate,

    pub const json_field_names = .{
        .standards_control_association_updates = "StandardsControlAssociationUpdates",
    };
};

pub const BatchUpdateStandardsControlAssociationsOutput = struct {
    /// A security control (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters) whose enablement status
    /// in a specified standard couldn't be updated.
    unprocessed_association_updates: ?[]const UnprocessedStandardsControlAssociationUpdate = null,

    pub const json_field_names = .{
        .unprocessed_association_updates = "UnprocessedAssociationUpdates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateStandardsControlAssociationsInput, options: CallOptions) !BatchUpdateStandardsControlAssociationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateStandardsControlAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/associations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StandardsControlAssociationUpdates\":");
    try aws.json.writeValue(@TypeOf(input.standards_control_association_updates), input.standards_control_association_updates, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateStandardsControlAssociationsOutput {
    var result: BatchUpdateStandardsControlAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateStandardsControlAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

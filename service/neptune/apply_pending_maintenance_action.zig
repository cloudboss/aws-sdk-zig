const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;
const serde = @import("serde.zig");

pub const ApplyPendingMaintenanceActionInput = struct {
    /// The pending maintenance action to apply to this resource.
    ///
    /// Valid values: `system-update`, `db-upgrade`
    apply_action: []const u8,

    /// A value that specifies the type of opt-in request, or undoes an opt-in
    /// request. An opt-in
    /// request of type `immediate` can't be undone.
    ///
    /// Valid values:
    ///
    /// * `immediate` - Apply the maintenance action immediately.
    ///
    /// * `next-maintenance` - Apply the maintenance action during the next
    /// maintenance window for the resource.
    ///
    /// * `undo-opt-in` - Cancel any existing `next-maintenance` opt-in
    /// requests.
    opt_in_type: []const u8,

    /// The Amazon Resource Name (ARN) of the resource that the pending maintenance
    /// action applies
    /// to. For information about creating an ARN, see [ Constructing an
    /// Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/neptune/latest/UserGuide/tagging.ARN.html#tagging.ARN.Constructing).
    resource_identifier: []const u8,
};

pub const ApplyPendingMaintenanceActionOutput = struct {
    resource_pending_maintenance_actions: ?ResourcePendingMaintenanceActions = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ApplyPendingMaintenanceActionInput, options: CallOptions) !ApplyPendingMaintenanceActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ApplyPendingMaintenanceActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "Neptune", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ApplyPendingMaintenanceAction&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&ApplyAction=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.apply_action);
    try body_buf.appendSlice(allocator, "&OptInType=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.opt_in_type);
    try body_buf.appendSlice(allocator, "&ResourceIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.resource_identifier);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ApplyPendingMaintenanceActionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ApplyPendingMaintenanceActionResult")) break;
            },
            else => {},
        }
    }

    var result: ApplyPendingMaintenanceActionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ResourcePendingMaintenanceActions")) {
                    result.resource_pending_maintenance_actions = try serde.deserializeResourcePendingMaintenanceActions(allocator, &reader);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

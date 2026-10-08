const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePendingMaintenanceActions = @import("resource_pending_maintenance_actions.zig").ResourcePendingMaintenanceActions;

pub const ApplyPendingMaintenanceActionInput = struct {
    /// The pending maintenance action to apply to this resource.
    ///
    /// Valid values: `os-upgrade`, `system-update`,
    /// `db-upgrade`, `os-patch`
    apply_action: []const u8,

    /// A value that specifies the type of opt-in request, or undoes an opt-in
    /// request. You
    /// can't undo an opt-in request of type `immediate`.
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

    /// The Amazon Resource Name (ARN) of the DMS resource that the pending
    /// maintenance action
    /// applies to.
    replication_instance_arn: []const u8,

    pub const json_field_names = .{
        .apply_action = "ApplyAction",
        .opt_in_type = "OptInType",
        .replication_instance_arn = "ReplicationInstanceArn",
    };
};

pub const ApplyPendingMaintenanceActionOutput = struct {
    /// The DMS resource that the pending maintenance action will be applied to.
    resource_pending_maintenance_actions: ?ResourcePendingMaintenanceActions = null,

    pub const json_field_names = .{
        .resource_pending_maintenance_actions = "ResourcePendingMaintenanceActions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ApplyPendingMaintenanceActionInput, options: CallOptions) !ApplyPendingMaintenanceActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ApplyPendingMaintenanceAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ApplyPendingMaintenanceActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ApplyPendingMaintenanceActionOutput, body, allocator);
}

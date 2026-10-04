const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningStatus = @import("provisioning_status.zig").ProvisioningStatus;
const Role = @import("role.zig").Role;
const ManagedThingSummary = @import("managed_thing_summary.zig").ManagedThingSummary;

pub const ListManagedThingsInput = struct {
    /// Filter managed things by the connector destination ID they are associated
    /// with.
    connector_destination_id_filter: ?[]const u8 = null,

    /// Filter managed things by the connector device ID they are associated with.
    /// When specified, only managed things with this connector device ID will be
    /// returned.
    connector_device_id_filter: ?[]const u8 = null,

    /// Filter on a connector policy id for a managed thing.
    connector_policy_id_filter: ?[]const u8 = null,

    /// Filter on a credential locker for a managed thing.
    credential_locker_filter: ?[]const u8 = null,

    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// A token that can be used to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    /// Filter on device owners when listing managed things.
    owner_filter: ?[]const u8 = null,

    /// Filter on a parent controller id for a managed thing.
    parent_controller_identifier_filter: ?[]const u8 = null,

    /// Filter on the status of the device. For more information, see [Device
    /// Provisioning](https://docs.aws.amazon.com/iot-mi/latest/devguide/device-provisioning.html).
    provisioning_status_filter: ?ProvisioningStatus = null,

    /// Filter on the type of device used. This will be the Amazon Web Services hub
    /// controller, cloud device, or IoT device.
    role_filter: ?Role = null,

    /// Filter on the serial number of the device.
    serial_number_filter: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_destination_id_filter = "ConnectorDestinationIdFilter",
        .connector_device_id_filter = "ConnectorDeviceIdFilter",
        .connector_policy_id_filter = "ConnectorPolicyIdFilter",
        .credential_locker_filter = "CredentialLockerFilter",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .owner_filter = "OwnerFilter",
        .parent_controller_identifier_filter = "ParentControllerIdentifierFilter",
        .provisioning_status_filter = "ProvisioningStatusFilter",
        .role_filter = "RoleFilter",
        .serial_number_filter = "SerialNumberFilter",
    };
};

pub const ListManagedThingsOutput = struct {
    /// The list of managed things.
    items: ?[]const ManagedThingSummary = null,

    /// A token that can be used to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListManagedThingsInput, options: CallOptions) !ListManagedThingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListManagedThingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/managed-things";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.connector_destination_id_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ConnectorDestinationIdFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.connector_device_id_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ConnectorDeviceIdFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.connector_policy_id_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ConnectorPolicyIdFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.credential_locker_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "CredentialLockerFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "MaxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "NextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.owner_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "OwnerFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.parent_controller_identifier_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ParentControllerIdentifierFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.provisioning_status_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ProvisioningStatusFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.role_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "RoleFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.serial_number_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "SerialNumberFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListManagedThingsOutput {
    const result: ListManagedThingsOutput = try aws.json.parseJsonObject(
        ListManagedThingsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateRegionSettingsInput = struct {
    /// Enables or disables full Backup management of backups for a resource type.
    /// To enable full Backup management for DynamoDB along with [
    /// Backup's advanced DynamoDB backup
    /// features](https://docs.aws.amazon.com/aws-backup/latest/devguide/advanced-ddb-backup.html), follow the
    /// procedure to [ enable advanced DynamoDB backup
    /// programmatically](https://docs.aws.amazon.com/aws-backup/latest/devguide/advanced-ddb-backup.html#advanced-ddb-backup-enable-cli).
    resource_type_management_preference: ?[]const aws.map.MapEntry(bool) = null,

    /// Updates the list of services along with the opt-in preferences for the
    /// Region.
    ///
    /// If resource assignments are only based on tags, then service opt-in settings
    /// are applied.
    /// If a resource type is explicitly assigned to a backup plan, such as Amazon
    /// S3,
    /// Amazon EC2, or Amazon RDS, it will be included in the
    /// backup even if the opt-in is not enabled for that particular service.
    /// If both a resource type and tags are specified in a resource assignment,
    /// the resource type specified in the backup plan takes priority over the
    /// tag condition. Service opt-in settings are disregarded in this situation.
    resource_type_opt_in_preference: ?[]const aws.map.MapEntry(bool) = null,

    pub const json_field_names = .{
        .resource_type_management_preference = "ResourceTypeManagementPreference",
        .resource_type_opt_in_preference = "ResourceTypeOptInPreference",
    };
};

pub const UpdateRegionSettingsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRegionSettingsInput, options: CallOptions) !UpdateRegionSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "backup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRegionSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/account-settings";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.resource_type_management_preference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTypeManagementPreference\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_type_opt_in_preference) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ResourceTypeOptInPreference\":");
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
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRegionSettingsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateRegionSettingsOutput = .{};

    return result;
}

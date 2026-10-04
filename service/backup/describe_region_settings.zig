const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeRegionSettingsInput = struct {
};

pub const DescribeRegionSettingsOutput = struct {
    /// Returns whether Backup fully manages the backups for a resource type.
    ///
    /// For the benefits of full Backup management, see [Full Backup
    /// management](https://docs.aws.amazon.com/aws-backup/latest/devguide/whatisbackup.html#full-management).
    ///
    /// For a list of resource types and whether each supports full Backup
    /// management,
    /// see the [Feature availability by
    /// resource](https://docs.aws.amazon.com/aws-backup/latest/devguide/backup-feature-availability.html#features-by-resource) table.
    ///
    /// If `"DynamoDB":false`, you can enable full Backup management for
    /// DynamoDB backup by enabling [
    /// Backup's advanced DynamoDB backup
    /// features](https://docs.aws.amazon.com/aws-backup/latest/devguide/advanced-ddb-backup.html#advanced-ddb-backup-enable-cli).
    resource_type_management_preference: ?[]const aws.map.MapEntry(bool) = null,

    /// The services along with the opt-in preferences in the Region.
    resource_type_opt_in_preference: ?[]const aws.map.MapEntry(bool) = null,

    pub const json_field_names = .{
        .resource_type_management_preference = "ResourceTypeManagementPreference",
        .resource_type_opt_in_preference = "ResourceTypeOptInPreference",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRegionSettingsInput, options: CallOptions) !DescribeRegionSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRegionSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/account-settings";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRegionSettingsOutput {
    var result: DescribeRegionSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeRegionSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeGlobalSettingsInput = struct {
};

pub const DescribeGlobalSettingsOutput = struct {
    /// The status of the flags `isCrossAccountBackupEnabled`, `isMpaEnabled` ('Mpa'
    /// refers to multi-party approval), and `isDelegatedAdministratorEnabled`.
    ///
    /// * `isCrossAccountBackupEnabled`: Allow accounts in your organization to copy
    ///   backups to other accounts.
    ///
    /// * `isMpaEnabled`: Add cross-account access to your organization with the
    ///   option to assign a Multi-party approval team to a logically air-gapped
    ///   vault.
    ///
    /// * `isDelegatedAdministratorEnabled`: Allow Backup to automatically
    ///   synchronize delegated administrator permissions with Organizations.
    global_settings: ?[]const aws.map.StringMapEntry = null,

    /// The date and time that the supported flags were last updated. This update is
    /// in Unix format and Coordinated Universal Time (UTC). The value of
    /// `LastUpdateTime` is accurate to milliseconds. For example, the value
    /// 1516925490.087 represents Friday, January 26, 2018 12:11:30.087 AM.
    last_update_time: ?i64 = null,

    pub const json_field_names = .{
        .global_settings = "GlobalSettings",
        .last_update_time = "LastUpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGlobalSettingsInput, options: CallOptions) !DescribeGlobalSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGlobalSettingsInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("backup", "Backup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/global-settings";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGlobalSettingsOutput {
    var result: DescribeGlobalSettingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeGlobalSettingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

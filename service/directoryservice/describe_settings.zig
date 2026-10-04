const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DirectoryConfigurationStatus = @import("directory_configuration_status.zig").DirectoryConfigurationStatus;
const SettingEntry = @import("setting_entry.zig").SettingEntry;

pub const DescribeSettingsInput = struct {
    /// The identifier of the directory for which to retrieve information.
    directory_id: []const u8,

    /// The `DescribeSettingsResult.NextToken` value from a previous call to
    /// DescribeSettings. Pass null if this is the first call.
    next_token: ?[]const u8 = null,

    /// The status of the directory settings for which to retrieve information.
    status: ?DirectoryConfigurationStatus = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .next_token = "NextToken",
        .status = "Status",
    };
};

pub const DescribeSettingsOutput = struct {
    /// The identifier of the directory.
    directory_id: ?[]const u8 = null,

    /// If not null, token that indicates that more results are available. Pass this
    /// value for the
    /// `NextToken` parameter in a subsequent call to `DescribeSettings` to
    /// retrieve the next set of items.
    next_token: ?[]const u8 = null,

    /// The list of SettingEntry objects that were retrieved.
    ///
    /// It is possible that this list contains less than the number of items
    /// specified in the
    /// `Limit` member of the request. This occurs if there are less than the
    /// requested
    /// number of items left to retrieve, or if the limitations of the operation
    /// have been
    /// exceeded.
    setting_entries: ?[]const SettingEntry = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .next_token = "NextToken",
        .setting_entries = "SettingEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSettingsInput, options: CallOptions) !DescribeSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ds", "Directory Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeSettingsOutput, body, allocator);
}

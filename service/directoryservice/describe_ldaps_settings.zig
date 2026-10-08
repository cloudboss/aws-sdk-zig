const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LDAPSType = @import("ldaps_type.zig").LDAPSType;
const LDAPSSettingInfo = @import("ldaps_setting_info.zig").LDAPSSettingInfo;

pub const DescribeLDAPSSettingsInput = struct {
    /// The identifier of the directory.
    directory_id: []const u8,

    /// Specifies the number of items that should be displayed on one page.
    limit: ?i32 = null,

    /// The type of next token used for pagination.
    next_token: ?[]const u8 = null,

    /// The type of LDAP security to enable. Currently only the value `Client` is
    /// supported.
    type: ?LDAPSType = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .limit = "Limit",
        .next_token = "NextToken",
        .type = "Type",
    };
};

pub const DescribeLDAPSSettingsOutput = struct {
    /// Information about LDAP security for the specified directory, including
    /// status of
    /// enablement, state last updated date time, and the reason for the state.
    ldaps_settings_info: ?[]const LDAPSSettingInfo = null,

    /// The next token used to retrieve the LDAPS settings if the number of setting
    /// types exceeds
    /// page limit and there is another page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ldaps_settings_info = "LDAPSSettingsInfo",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLDAPSSettingsInput, options: CallOptions) !DescribeLDAPSSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLDAPSSettingsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeLDAPSSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLDAPSSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLDAPSSettingsOutput, body, allocator);
}

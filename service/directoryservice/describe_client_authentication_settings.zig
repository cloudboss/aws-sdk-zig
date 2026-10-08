const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClientAuthenticationType = @import("client_authentication_type.zig").ClientAuthenticationType;
const ClientAuthenticationSettingInfo = @import("client_authentication_setting_info.zig").ClientAuthenticationSettingInfo;

pub const DescribeClientAuthenticationSettingsInput = struct {
    /// The identifier of the directory for which to retrieve information.
    directory_id: []const u8,

    /// The maximum number of items to return. If this value is zero, the maximum
    /// number of items
    /// is specified by the limitations of the operation.
    limit: ?i32 = null,

    /// The *DescribeClientAuthenticationSettingsResult.NextToken* value from a
    /// previous call to DescribeClientAuthenticationSettings. Pass null if this is
    /// the first call.
    next_token: ?[]const u8 = null,

    /// The type of client authentication for which to retrieve information. If no
    /// type is
    /// specified, a list of all client authentication types that are supported for
    /// the specified
    /// directory is retrieved.
    type: ?ClientAuthenticationType = null,

    pub const json_field_names = .{
        .directory_id = "DirectoryId",
        .limit = "Limit",
        .next_token = "NextToken",
        .type = "Type",
    };
};

pub const DescribeClientAuthenticationSettingsOutput = struct {
    /// Information about the type of client authentication for the specified
    /// directory. The
    /// following information is retrieved: The date and time when the status of the
    /// client
    /// authentication type was last updated, whether the client authentication type
    /// is enabled or
    /// disabled, and the type of client authentication.
    client_authentication_settings_info: ?[]const ClientAuthenticationSettingInfo = null,

    /// The next token used to retrieve the client authentication settings if the
    /// number of
    /// setting types exceeds page limit and there is another page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_authentication_settings_info = "ClientAuthenticationSettingsInfo",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeClientAuthenticationSettingsInput, options: CallOptions) !DescribeClientAuthenticationSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeClientAuthenticationSettingsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DirectoryService_20150416.DescribeClientAuthenticationSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeClientAuthenticationSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeClientAuthenticationSettingsOutput, body, allocator);
}

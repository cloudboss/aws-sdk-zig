const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SettingName = @import("setting_name.zig").SettingName;
const Setting = @import("setting.zig").Setting;

pub const ListAccountSettingsInput = struct {
    /// Determines whether to return the effective settings. If `true`, the account
    /// settings for the root user or the default setting for the `principalArn` are
    /// returned. If `false`, the account settings for the `principalArn` are
    /// returned if they're set. Otherwise, no account settings are returned.
    effective_settings: ?bool = null,

    /// The maximum number of account setting results returned by
    /// `ListAccountSettings` in paginated output. When this parameter is used,
    /// `ListAccountSettings` only returns `maxResults` results in a single page
    /// along with a `nextToken` response element. The remaining results of the
    /// initial request can be seen by sending another `ListAccountSettings` request
    /// with the returned `nextToken` value. This value can be between 1 and 10. If
    /// this parameter isn't used, then `ListAccountSettings` returns up to 10
    /// results and a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The name of the account setting you want to list the settings for.
    name: ?SettingName = null,

    /// The `nextToken` value returned from a `ListAccountSettings` request
    /// indicating that more results are available to fulfill the request and
    /// further calls will be needed. If `maxResults` was provided, it's possible
    /// the number of results to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The ARN of the principal, which can be a user, role, or the root user. If
    /// this field is omitted, the account settings are listed only for the
    /// authenticated user.
    ///
    /// In order to use this parameter, you must be the root user, or the principal.
    ///
    /// Federated users assume the account setting of the root user and can't have
    /// explicit account settings set for them.
    principal_arn: ?[]const u8 = null,

    /// The value of the account settings to filter results with. You must also
    /// specify an account setting name to use this parameter.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .effective_settings = "effectiveSettings",
        .max_results = "maxResults",
        .name = "name",
        .next_token = "nextToken",
        .principal_arn = "principalArn",
        .value = "value",
    };
};

pub const ListAccountSettingsOutput = struct {
    /// The `nextToken` value to include in a future `ListAccountSettings` request.
    /// When the results of a `ListAccountSettings` request exceed `maxResults`,
    /// this value can be used to retrieve the next page of results. This value is
    /// `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The account settings for the resource.
    settings: ?[]const Setting = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .settings = "settings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAccountSettingsInput, options: CallOptions) !ListAccountSettingsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAccountSettingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListAccountSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAccountSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAccountSettingsOutput, body, allocator);
}

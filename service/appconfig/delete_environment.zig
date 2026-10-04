const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeletionProtectionCheck = @import("deletion_protection_check.zig").DeletionProtectionCheck;

pub const DeleteEnvironmentInput = struct {
    /// The application ID that includes the environment that you want to delete.
    application_id: []const u8,

    /// A parameter to configure deletion protection. Deletion protection prevents a
    /// user from
    /// deleting an environment if your application called either
    /// [GetLatestConfiguration](https://docs.aws.amazon.com/appconfig/2019-10-09/APIReference/API_appconfigdata_GetLatestConfiguration.html) or in the
    /// environment during the specified interval.
    ///
    /// This parameter supports the following values:
    ///
    /// * `BYPASS`: Instructs AppConfig to bypass the deletion
    /// protection check and delete a configuration profile even if deletion
    /// protection would
    /// have otherwise prevented it.
    ///
    /// * `APPLY`: Instructs the deletion protection check to run, even if
    /// deletion protection is disabled at the account level. `APPLY` also forces
    /// the deletion protection check to run against resources created in the past
    /// hour,
    /// which are normally excluded from deletion protection checks.
    ///
    /// * `ACCOUNT_DEFAULT`: The default setting, which instructs AppConfig to
    ///   implement the deletion protection value specified in the
    /// `UpdateAccountSettings` API.
    deletion_protection_check: ?DeletionProtectionCheck = null,

    /// The ID of the environment that you want to delete.
    environment_id: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .deletion_protection_check = "DeletionProtectionCheck",
        .environment_id = "EnvironmentId",
    };
};

pub const DeleteEnvironmentOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteEnvironmentInput, options: CallOptions) !DeleteEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.deletion_protection_check) |v| {
        try request.headers.put(allocator, "x-amzn-deletion-protection-check", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteEnvironmentOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteEnvironmentOutput = .{};

    return result;
}

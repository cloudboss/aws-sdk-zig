const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceProfile = @import("instance_profile.zig").InstanceProfile;

pub const CreateInstanceProfileInput = struct {
    /// The description of your instance profile.
    description: ?[]const u8 = null,

    /// An array of strings that specifies the list of app packages that should not
    /// be cleaned up from the device
    /// after a test run.
    ///
    /// The list of packages is considered only if you set `packageCleanup` to
    /// `true`.
    exclude_app_packages_from_cleanup: ?[]const []const u8 = null,

    /// The name of your instance profile.
    name: []const u8,

    /// When set to `true`, Device Farm removes app packages after a test run. The
    /// default value is
    /// `false` for private devices.
    package_cleanup: ?bool = null,

    /// When set to `true`, Device Farm reboots the instance after a test run. The
    /// default value is
    /// `true`.
    reboot_after_use: ?bool = null,

    pub const json_field_names = .{
        .description = "description",
        .exclude_app_packages_from_cleanup = "excludeAppPackagesFromCleanup",
        .name = "name",
        .package_cleanup = "packageCleanup",
        .reboot_after_use = "rebootAfterUse",
    };
};

pub const CreateInstanceProfileOutput = struct {
    /// An object that contains information about your instance profile.
    instance_profile: ?InstanceProfile = null,

    pub const json_field_names = .{
        .instance_profile = "instanceProfile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstanceProfileInput, options: CallOptions) !CreateInstanceProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "devicefarm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstanceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("devicefarm", "Device Farm", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DeviceFarm_20150623.CreateInstanceProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstanceProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInstanceProfileOutput, body, allocator);
}

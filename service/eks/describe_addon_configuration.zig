const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddonPodIdentityConfiguration = @import("addon_pod_identity_configuration.zig").AddonPodIdentityConfiguration;

pub const DescribeAddonConfigurationInput = struct {
    /// The name of the add-on. The name must match one of the names returned by
    /// `DescribeAddonVersions`.
    addon_name: []const u8,

    /// The version of the add-on. The version must match one of the versions
    /// returned by [
    /// `DescribeAddonVersions`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_DescribeAddonVersions.html).
    addon_version: []const u8,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .addon_version = "addonVersion",
    };
};

pub const DescribeAddonConfigurationOutput = struct {
    /// The name of the add-on.
    addon_name: ?[]const u8 = null,

    /// The version of the add-on. The version must match one of the versions
    /// returned by [
    /// `DescribeAddonVersions`
    /// ](https://docs.aws.amazon.com/eks/latest/APIReference/API_DescribeAddonVersions.html).
    addon_version: ?[]const u8 = null,

    /// A JSON schema that's used to validate the configuration values you provide
    /// when an
    /// add-on is created or updated.
    configuration_schema: ?[]const u8 = null,

    /// The Kubernetes service account name used by the add-on, and any suggested
    /// IAM policies.
    /// Use this information to create an IAM Role for the add-on.
    pod_identity_configuration: ?[]const AddonPodIdentityConfiguration = null,

    pub const json_field_names = .{
        .addon_name = "addonName",
        .addon_version = "addonVersion",
        .configuration_schema = "configurationSchema",
        .pod_identity_configuration = "podIdentityConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAddonConfigurationInput, options: CallOptions) !DescribeAddonConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "eks", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAddonConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("eks", "EKS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/addons/configuration-schemas";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "addonName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.addon_name);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "addonVersion=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.addon_version);
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAddonConfigurationOutput {
    var result: DescribeAddonConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeAddonConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

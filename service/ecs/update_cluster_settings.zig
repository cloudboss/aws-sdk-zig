const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusterSetting = @import("cluster_setting.zig").ClusterSetting;
const Cluster = @import("cluster.zig").Cluster;

pub const UpdateClusterSettingsInput = struct {
    /// The name of the cluster to modify the settings for.
    cluster: []const u8,

    /// The setting to use by default for a cluster. This parameter is used to turn
    /// on CloudWatch Container Insights for a cluster. If this value is specified,
    /// it overrides the `containerInsights` value set with
    /// [PutAccountSetting](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAccountSetting.html) or [PutAccountSettingDefault](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_PutAccountSettingDefault.html).
    ///
    /// Currently, if you delete an existing cluster that does not have Container
    /// Insights turned on, and then create a new cluster with the same name with
    /// Container Insights tuned on, Container Insights will not actually be turned
    /// on. If you want to preserve the same name for your existing cluster and turn
    /// on Container Insights, you must wait 7 days before you can re-create it.
    settings: []const ClusterSetting,

    pub const json_field_names = .{
        .cluster = "cluster",
        .settings = "settings",
    };
};

pub const UpdateClusterSettingsOutput = struct {
    /// Details about the cluster
    cluster: ?Cluster = null,

    pub const json_field_names = .{
        .cluster = "cluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterSettingsInput, options: CallOptions) !UpdateClusterSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterSettingsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateClusterSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateClusterSettingsOutput, body, allocator);
}

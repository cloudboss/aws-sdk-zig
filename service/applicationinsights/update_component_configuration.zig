const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tier = @import("tier.zig").Tier;

pub const UpdateComponentConfigurationInput = struct {
    /// Automatically configures the component by applying the recommended
    /// configurations.
    auto_config_enabled: ?bool = null,

    /// The configuration settings of the component. The value is the escaped JSON
    /// of the
    /// configuration. For more information about the JSON format, see [Working with
    /// JSON](https://docs.aws.amazon.com/sdk-for-javascript/v2/developer-guide/working-with-json.html). You can send a request to
    /// `DescribeComponentConfigurationRecommendation` to see the recommended
    /// configuration for a component. For the complete format of the component
    /// configuration file,
    /// see [Component
    /// Configuration](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/component-config.html).
    component_configuration: ?[]const u8 = null,

    /// The name of the component.
    component_name: []const u8,

    /// Indicates whether the application component is monitored.
    monitor: ?bool = null,

    /// The name of the resource group.
    resource_group_name: []const u8,

    /// The tier of the application component.
    tier: ?Tier = null,

    pub const json_field_names = .{
        .auto_config_enabled = "AutoConfigEnabled",
        .component_configuration = "ComponentConfiguration",
        .component_name = "ComponentName",
        .monitor = "Monitor",
        .resource_group_name = "ResourceGroupName",
        .tier = "Tier",
    };
};

pub const UpdateComponentConfigurationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateComponentConfigurationInput, options: CallOptions) !UpdateComponentConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "applicationinsights", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateComponentConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationinsights", "Application Insights", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "EC2WindowsBarleyService.UpdateComponentConfiguration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateComponentConfigurationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

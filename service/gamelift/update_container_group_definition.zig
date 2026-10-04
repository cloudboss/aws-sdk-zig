const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GameServerContainerDefinitionInput = @import("game_server_container_definition_input.zig").GameServerContainerDefinitionInput;
const ContainerOperatingSystem = @import("container_operating_system.zig").ContainerOperatingSystem;
const SupportContainerDefinitionInput = @import("support_container_definition_input.zig").SupportContainerDefinitionInput;
const ContainerGroupDefinition = @import("container_group_definition.zig").ContainerGroupDefinition;

pub const UpdateContainerGroupDefinitionInput = struct {
    /// An updated definition for the game server container in this group. Define a
    /// game server
    /// container only when the container group type is `GAME_SERVER`. You can pass
    /// in your
    /// container definitions as a JSON file.
    game_server_container_definition: ?GameServerContainerDefinitionInput = null,

    /// A descriptive identifier for the container group definition. The name value
    /// must be unique in an Amazon Web Services Region.
    name: []const u8,

    /// The platform that all containers in the group use. Containers in a group
    /// must run on the
    /// same operating system.
    ///
    /// Amazon Linux 2 (AL2) will reach end of support on 6/30/2026. See more
    /// details in the [Amazon Linux 2
    /// FAQs](http://aws.amazon.com/amazon-linux-2/faqs/). For game
    /// servers that are hosted on AL2 and use server SDK version 4.x for Amazon
    /// GameLift Servers, first update the game
    /// server build to server SDK 5.x, and then deploy to AL2023 instances. See [
    /// Migrate to
    /// server SDK version
    /// 5.](https://docs.aws.amazon.com/gamelift/latest/developerguide/reference-serversdk5-migration.html)
    operating_system: ?ContainerOperatingSystem = null,

    /// The container group definition version to update. The new version starts
    /// with values from
    /// the source version, and then updates values included in this request.
    source_version_number: ?i32 = null,

    /// One or more definitions for support containers in this group. You can define
    /// a support
    /// container in any type of container group. You can pass in your container
    /// definitions as a JSON
    /// file.
    support_container_definitions: ?[]const SupportContainerDefinitionInput = null,

    /// The maximum amount of memory (in MiB) to allocate to the container group.
    /// All containers in
    /// the group share this memory. If you specify memory limits for an individual
    /// container, the
    /// total value must be greater than any individual container's memory limit.
    total_memory_limit_mebibytes: ?i32 = null,

    /// The maximum amount of vCPU units to allocate to the container group (1 vCPU
    /// is equal to 1024
    /// CPU units). All containers in the group share this memory. If you specify
    /// vCPU limits for
    /// individual containers, the total value must be equal to or greater than the
    /// sum of the CPU
    /// limits for all containers in the group.
    total_vcpu_limit: ?f64 = null,

    /// A description for this update to the container group definition.
    version_description: ?[]const u8 = null,

    pub const json_field_names = .{
        .game_server_container_definition = "GameServerContainerDefinition",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .source_version_number = "SourceVersionNumber",
        .support_container_definitions = "SupportContainerDefinitions",
        .total_memory_limit_mebibytes = "TotalMemoryLimitMebibytes",
        .total_vcpu_limit = "TotalVcpuLimit",
        .version_description = "VersionDescription",
    };
};

pub const UpdateContainerGroupDefinitionOutput = struct {
    /// The properties of the updated container group definition version.
    container_group_definition: ?ContainerGroupDefinition = null,

    pub const json_field_names = .{
        .container_group_definition = "ContainerGroupDefinition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContainerGroupDefinitionInput, options: CallOptions) !UpdateContainerGroupDefinitionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gamelift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContainerGroupDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gamelift", "GameLift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "GameLift.UpdateContainerGroupDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContainerGroupDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContainerGroupDefinitionOutput, body, allocator);
}

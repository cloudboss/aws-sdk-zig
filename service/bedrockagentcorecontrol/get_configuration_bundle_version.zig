const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComponentConfiguration = @import("component_configuration.zig").ComponentConfiguration;
const VersionLineageMetadata = @import("version_lineage_metadata.zig").VersionLineageMetadata;

pub const GetConfigurationBundleVersionInput = struct {
    /// The unique identifier of the configuration bundle.
    bundle_id: []const u8,

    /// The version identifier of the configuration bundle version to retrieve.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_id = "bundleId",
        .version_id = "versionId",
    };
};

pub const GetConfigurationBundleVersionOutput = struct {
    /// The Amazon Resource Name (ARN) of the configuration bundle.
    bundle_arn: []const u8,

    /// The unique identifier of the configuration bundle.
    bundle_id: []const u8,

    /// The name of the configuration bundle.
    bundle_name: []const u8,

    /// A map of component identifiers to their configurations for this version.
    components: ?[]const aws.map.MapEntry(ComponentConfiguration) = null,

    /// The timestamp when the configuration bundle was created.
    created_at: i64,

    /// The description of the configuration bundle.
    description: ?[]const u8 = null,

    /// The version lineage metadata, including parent versions, branch name, and
    /// creation source.
    lineage_metadata: ?VersionLineageMetadata = null,

    /// The timestamp when this specific version was created.
    version_created_at: i64,

    /// The version identifier of this configuration bundle version.
    version_id: []const u8,

    pub const json_field_names = .{
        .bundle_arn = "bundleArn",
        .bundle_id = "bundleId",
        .bundle_name = "bundleName",
        .components = "components",
        .created_at = "createdAt",
        .description = "description",
        .lineage_metadata = "lineageMetadata",
        .version_created_at = "versionCreatedAt",
        .version_id = "versionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetConfigurationBundleVersionInput, options: CallOptions) !GetConfigurationBundleVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetConfigurationBundleVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configuration-bundles/");
    try path_buf.appendSlice(allocator, input.bundle_id);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetConfigurationBundleVersionOutput {
    var result: GetConfigurationBundleVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetConfigurationBundleVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

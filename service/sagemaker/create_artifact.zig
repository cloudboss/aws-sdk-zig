const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ArtifactSource = @import("artifact_source.zig").ArtifactSource;
const Tag = @import("tag.zig").Tag;

pub const CreateArtifactInput = struct {
    /// The name of the artifact. Must be unique to your account in an Amazon Web
    /// Services Region.
    artifact_name: ?[]const u8 = null,

    /// The artifact type.
    artifact_type: []const u8,

    metadata_properties: ?MetadataProperties = null,

    /// A list of properties to add to the artifact.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The ID, ID type, and URI of the source.
    source: ArtifactSource,

    /// A list of tags to apply to the artifact.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .artifact_name = "ArtifactName",
        .artifact_type = "ArtifactType",
        .metadata_properties = "MetadataProperties",
        .properties = "Properties",
        .source = "Source",
        .tags = "Tags",
    };
};

pub const CreateArtifactOutput = struct {
    /// The Amazon Resource Name (ARN) of the artifact.
    artifact_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_arn = "ArtifactArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateArtifactInput, options: CallOptions) !CreateArtifactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateArtifactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateArtifactOutput, body, allocator);
}

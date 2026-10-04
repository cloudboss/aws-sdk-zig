const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ArtifactSource = @import("artifact_source.zig").ArtifactSource;

pub const DescribeArtifactInput = struct {
    /// The Amazon Resource Name (ARN) of the artifact to describe.
    artifact_arn: []const u8,

    pub const json_field_names = .{
        .artifact_arn = "ArtifactArn",
    };
};

pub const DescribeArtifactOutput = struct {
    /// The Amazon Resource Name (ARN) of the artifact.
    artifact_arn: ?[]const u8 = null,

    /// The name of the artifact.
    artifact_name: ?[]const u8 = null,

    /// The type of the artifact.
    artifact_type: ?[]const u8 = null,

    created_by: ?UserContext = null,

    /// When the artifact was created.
    creation_time: ?i64 = null,

    last_modified_by: ?UserContext = null,

    /// When the artifact was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the lineage group.
    lineage_group_arn: ?[]const u8 = null,

    metadata_properties: ?MetadataProperties = null,

    /// A list of the artifact's properties.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The source of the artifact.
    source: ?ArtifactSource = null,

    pub const json_field_names = .{
        .artifact_arn = "ArtifactArn",
        .artifact_name = "ArtifactName",
        .artifact_type = "ArtifactType",
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .lineage_group_arn = "LineageGroupArn",
        .metadata_properties = "MetadataProperties",
        .properties = "Properties",
        .source = "Source",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeArtifactInput, options: CallOptions) !DescribeArtifactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeArtifactInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeArtifact");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeArtifactOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeArtifactOutput, body, allocator);
}

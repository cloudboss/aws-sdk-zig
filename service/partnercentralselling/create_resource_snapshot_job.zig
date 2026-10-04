const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;
const Tag = @import("tag.zig").Tag;

pub const CreateResourceSnapshotJobInput = struct {
    /// Specifies the catalog in which to create the snapshot job. Valid values are
    /// `AWS` and ` Sandbox`.
    catalog: []const u8,

    /// A client-generated UUID used for idempotency check. The token helps prevent
    /// duplicate job creations.
    client_token: []const u8,

    /// Specifies the identifier of the engagement associated with the resource to
    /// be snapshotted.
    engagement_identifier: []const u8,

    /// Specifies the identifier of the specific resource to be snapshotted. The
    /// format depends on the ` ResourceType`.
    resource_identifier: []const u8,

    /// Specifies the name of the template that defines the schema for the snapshot.
    resource_snapshot_template_identifier: []const u8,

    /// The type of resource for which the snapshot job is being created. Must be
    /// one of the supported resource types i.e. `Opportunity`
    resource_type: ResourceType,

    /// A map of the key-value pairs of the tag or tags to assign.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .engagement_identifier = "EngagementIdentifier",
        .resource_identifier = "ResourceIdentifier",
        .resource_snapshot_template_identifier = "ResourceSnapshotTemplateIdentifier",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};

pub const CreateResourceSnapshotJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the created snapshot job.
    arn: ?[]const u8 = null,

    /// The unique identifier for the created snapshot job.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceSnapshotJobInput, options: CallOptions) !CreateResourceSnapshotJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "partnercentral", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceSnapshotJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("partnercentral-selling", "PartnerCentral Selling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.CreateResourceSnapshotJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceSnapshotJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResourceSnapshotJobOutput, body, allocator);
}

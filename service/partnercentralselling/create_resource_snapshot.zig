const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceType = @import("resource_type.zig").ResourceType;

pub const CreateResourceSnapshotInput = struct {
    /// Specifies the catalog where the snapshot is created. Valid values are `AWS`
    /// and `Sandbox`.
    catalog: []const u8,

    /// Specifies a unique, client-generated UUID to ensure that the request is
    /// handled exactly once. This token helps prevent duplicate snapshot creations.
    client_token: []const u8,

    /// The unique identifier of the engagement associated with this snapshot. This
    /// field links the snapshot to a specific engagement context.
    engagement_identifier: []const u8,

    /// The unique identifier of the specific resource to be snapshotted. The format
    /// and constraints of this identifier depend on the `ResourceType` specified.
    /// For example: For `Opportunity` type, it will be an opportunity ID.
    resource_identifier: []const u8,

    /// The name of the template that defines the schema for the snapshot. This
    /// template determines which subset of the resource data will be included in
    /// the snapshot. Must correspond to an existing and valid template for the
    /// specified `ResourceType`.
    resource_snapshot_template_identifier: []const u8,

    /// Specifies the type of resource for which the snapshot is being created. This
    /// field determines the structure and content of the snapshot. Must be one of
    /// the supported resource types, such as: `Opportunity`.
    resource_type: ResourceType,

    pub const json_field_names = .{
        .catalog = "Catalog",
        .client_token = "ClientToken",
        .engagement_identifier = "EngagementIdentifier",
        .resource_identifier = "ResourceIdentifier",
        .resource_snapshot_template_identifier = "ResourceSnapshotTemplateIdentifier",
        .resource_type = "ResourceType",
    };
};

pub const CreateResourceSnapshotOutput = struct {
    /// Specifies the Amazon Resource Name (ARN) that uniquely identifies the
    /// snapshot created.
    arn: ?[]const u8 = null,

    /// Specifies the revision number of the created snapshot. This field provides
    /// important information about the snapshot's place in the sequence of
    /// snapshots for the given resource.
    revision: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .revision = "Revision",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateResourceSnapshotInput, options: CallOptions) !CreateResourceSnapshotOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateResourceSnapshotInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSPartnerCentralSelling.CreateResourceSnapshot");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateResourceSnapshotOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateResourceSnapshotOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateOpsItemRelatedItemInput = struct {
    /// The type of association that you want to create between an OpsItem and a
    /// resource. OpsCenter
    /// supports `IsParentOf` and `RelatesTo` association types.
    association_type: []const u8,

    /// The ID of the OpsItem to which you want to associate a resource as a related
    /// item.
    ops_item_id: []const u8,

    /// The type of resource that you want to associate with an OpsItem. OpsCenter
    /// supports the
    /// following types:
    ///
    /// `AWS::SSMIncidents::IncidentRecord`: an Incident Manager incident.
    ///
    /// `AWS::SSM::Document`: a Systems Manager (SSM) document.
    resource_type: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services resource that you
    /// want to associate with the
    /// OpsItem.
    resource_uri: []const u8,

    pub const json_field_names = .{
        .association_type = "AssociationType",
        .ops_item_id = "OpsItemId",
        .resource_type = "ResourceType",
        .resource_uri = "ResourceUri",
    };
};

pub const AssociateOpsItemRelatedItemOutput = struct {
    /// The association ID.
    association_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateOpsItemRelatedItemInput, options: CallOptions) !AssociateOpsItemRelatedItemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateOpsItemRelatedItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.AssociateOpsItemRelatedItem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateOpsItemRelatedItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(AssociateOpsItemRelatedItemOutput, body, allocator);
}

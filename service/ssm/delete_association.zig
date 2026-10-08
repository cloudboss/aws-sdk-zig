const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteAssociationInput = struct {
    /// The association ID that you want to delete.
    association_id: ?[]const u8 = null,

    /// The managed node ID.
    ///
    /// `InstanceId` has been deprecated. To specify a managed node ID for an
    /// association, use the `Targets` parameter. Requests that include the
    /// parameter
    /// `InstanceID` with Systems Manager documents (SSM documents) that use schema
    /// version 2.0 or
    /// later will fail. In addition, if you use the parameter `InstanceId`, you
    /// can't use
    /// the parameters `AssociationName`, `DocumentVersion`,
    /// `MaxErrors`, `MaxConcurrency`, `OutputLocation`, or
    /// `ScheduleExpression`. To use these parameters, you must use the `Targets`
    /// parameter.
    instance_id: ?[]const u8 = null,

    /// The name of the SSM document.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .instance_id = "InstanceId",
        .name = "Name",
    };
};

pub const DeleteAssociationOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteAssociationInput, options: CallOptions) !DeleteAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteAssociationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DeleteAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteAssociationOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}

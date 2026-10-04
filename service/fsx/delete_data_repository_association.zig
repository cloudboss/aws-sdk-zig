const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataRepositoryLifecycle = @import("data_repository_lifecycle.zig").DataRepositoryLifecycle;

pub const DeleteDataRepositoryAssociationInput = struct {
    /// The ID of the data repository association that you want to delete.
    association_id: []const u8,

    client_request_token: ?[]const u8 = null,

    /// Set to `true` to delete the data in the file system that corresponds
    /// to the data repository association.
    delete_data_in_file_system: ?bool = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .client_request_token = "ClientRequestToken",
        .delete_data_in_file_system = "DeleteDataInFileSystem",
    };
};

pub const DeleteDataRepositoryAssociationOutput = struct {
    /// The ID of the data repository association being deleted.
    association_id: ?[]const u8 = null,

    /// Indicates whether data in the file system that corresponds to the data
    /// repository association is being deleted. Default is `false`.
    delete_data_in_file_system: ?bool = null,

    /// Describes the lifecycle state of the data repository association being
    /// deleted.
    lifecycle: ?DataRepositoryLifecycle = null,

    pub const json_field_names = .{
        .association_id = "AssociationId",
        .delete_data_in_file_system = "DeleteDataInFileSystem",
        .lifecycle = "Lifecycle",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDataRepositoryAssociationInput, options: CallOptions) !DeleteDataRepositoryAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDataRepositoryAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.DeleteDataRepositoryAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDataRepositoryAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteDataRepositoryAssociationOutput, body, allocator);
}

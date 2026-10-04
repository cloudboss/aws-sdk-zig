const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataValue = @import("metadata_value.zig").MetadataValue;

pub const UpdateOpsMetadataInput = struct {
    /// The metadata keys to delete from the OpsMetadata object.
    keys_to_delete: ?[]const []const u8 = null,

    /// Metadata to add to an OpsMetadata object.
    metadata_to_update: ?[]const aws.map.MapEntry(MetadataValue) = null,

    /// The Amazon Resource Name (ARN) of the OpsMetadata Object to update.
    ops_metadata_arn: []const u8,

    pub const json_field_names = .{
        .keys_to_delete = "KeysToDelete",
        .metadata_to_update = "MetadataToUpdate",
        .ops_metadata_arn = "OpsMetadataArn",
    };
};

pub const UpdateOpsMetadataOutput = struct {
    /// The Amazon Resource Name (ARN) of the OpsMetadata Object that was updated.
    ops_metadata_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .ops_metadata_arn = "OpsMetadataArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOpsMetadataInput, options: CallOptions) !UpdateOpsMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOpsMetadataInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateOpsMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOpsMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateOpsMetadataOutput, body, allocator);
}

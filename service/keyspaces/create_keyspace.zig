const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ReplicationSpecification = @import("replication_specification.zig").ReplicationSpecification;
const Tag = @import("tag.zig").Tag;

pub const CreateKeyspaceInput = struct {
    /// The name of the keyspace to be created.
    keyspace_name: []const u8,

    /// The replication specification of the keyspace includes:
    ///
    /// * `replicationStrategy` - the required value is `SINGLE_REGION` or
    ///   `MULTI_REGION`.
    /// * `regionList` - if the `replicationStrategy` is `MULTI_REGION`, the
    ///   `regionList` requires the current Region and at least one additional
    ///   Amazon Web Services Region where the keyspace is going to be replicated
    ///   in.
    replication_specification: ?ReplicationSpecification = null,

    /// A list of key-value pair tags to be attached to the keyspace.
    ///
    /// For more information, see [Adding tags and labels to Amazon Keyspaces
    /// resources](https://docs.aws.amazon.com/keyspaces/latest/devguide/tagging-keyspaces.html) in the *Amazon Keyspaces Developer Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .replication_specification = "replicationSpecification",
        .tags = "tags",
    };
};

pub const CreateKeyspaceOutput = struct {
    /// The unique identifier of the keyspace in the format of an Amazon Resource
    /// Name (ARN).
    resource_arn: []const u8,

    pub const json_field_names = .{
        .resource_arn = "resourceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateKeyspaceInput, options: CallOptions) !CreateKeyspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cassandra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateKeyspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cassandra", "Keyspaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.CreateKeyspace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateKeyspaceOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateKeyspaceOutput, body, allocator);
}

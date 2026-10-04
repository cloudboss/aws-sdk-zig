const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const ReplicationSubnetGroup = @import("replication_subnet_group.zig").ReplicationSubnetGroup;

pub const CreateReplicationSubnetGroupInput = struct {
    /// The description for the subnet group.
    ///
    /// Constraints: This parameter Must not contain non-printable control
    /// characters.
    replication_subnet_group_description: []const u8,

    /// The name for the replication subnet group. This value is stored as a
    /// lowercase
    /// string.
    ///
    /// Constraints: Must contain no more than 255 alphanumeric characters, periods,
    /// underscores, or hyphens. Must not be "default".
    ///
    /// Example: `mySubnetgroup`
    replication_subnet_group_identifier: []const u8,

    /// Two or more subnet IDs to be assigned to the subnet group.
    subnet_ids: []const []const u8,

    /// One or more tags to be assigned to the subnet group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .replication_subnet_group_description = "ReplicationSubnetGroupDescription",
        .replication_subnet_group_identifier = "ReplicationSubnetGroupIdentifier",
        .subnet_ids = "SubnetIds",
        .tags = "Tags",
    };
};

pub const CreateReplicationSubnetGroupOutput = struct {
    /// The replication subnet group that was created.
    replication_subnet_group: ?ReplicationSubnetGroup = null,

    pub const json_field_names = .{
        .replication_subnet_group = "ReplicationSubnetGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationSubnetGroupInput, options: CallOptions) !CreateReplicationSubnetGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationSubnetGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateReplicationSubnetGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationSubnetGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateReplicationSubnetGroupOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HdfsAuthenticationType = @import("hdfs_authentication_type.zig").HdfsAuthenticationType;
const HdfsNameNode = @import("hdfs_name_node.zig").HdfsNameNode;
const QopConfiguration = @import("qop_configuration.zig").QopConfiguration;

pub const DescribeLocationHdfsInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the HDFS location.
    location_arn: []const u8,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub const DescribeLocationHdfsOutput = struct {
    /// The ARNs of the DataSync agents that can connect with your HDFS cluster.
    agent_arns: ?[]const []const u8 = null,

    /// The type of authentication used to determine the identity of the user.
    authentication_type: ?HdfsAuthenticationType = null,

    /// The size of the data blocks to write into the HDFS cluster.
    block_size: ?i32 = null,

    /// The time that the HDFS location was created.
    creation_time: ?i64 = null,

    /// The Kerberos principal with access to the files and folders on the HDFS
    /// cluster. This
    /// parameter is used if the `AuthenticationType` is defined as
    /// `KERBEROS`.
    kerberos_principal: ?[]const u8 = null,

    /// The URI of the HDFS cluster's Key Management Server (KMS).
    kms_key_provider_uri: ?[]const u8 = null,

    /// The ARN of the HDFS location.
    location_arn: ?[]const u8 = null,

    /// The URI of the HDFS location.
    location_uri: ?[]const u8 = null,

    /// The NameNode that manages the HDFS namespace.
    name_nodes: ?[]const HdfsNameNode = null,

    /// The Quality of Protection (QOP) configuration, which specifies the Remote
    /// Procedure Call
    /// (RPC) and data transfer protection settings configured on the HDFS cluster.
    qop_configuration: ?QopConfiguration = null,

    /// The number of DataNodes to replicate the data to when writing to the HDFS
    /// cluster.
    replication_factor: ?i32 = null,

    /// The user name to identify the client on the host operating system. This
    /// parameter is used
    /// if the `AuthenticationType` is defined as `SIMPLE`.
    simple_user: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .authentication_type = "AuthenticationType",
        .block_size = "BlockSize",
        .creation_time = "CreationTime",
        .kerberos_principal = "KerberosPrincipal",
        .kms_key_provider_uri = "KmsKeyProviderUri",
        .location_arn = "LocationArn",
        .location_uri = "LocationUri",
        .name_nodes = "NameNodes",
        .qop_configuration = "QopConfiguration",
        .replication_factor = "ReplicationFactor",
        .simple_user = "SimpleUser",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeLocationHdfsInput, options: CallOptions) !DescribeLocationHdfsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeLocationHdfsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeLocationHdfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeLocationHdfsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeLocationHdfsOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}

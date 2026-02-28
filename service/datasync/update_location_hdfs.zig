const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HdfsAuthenticationType = @import("hdfs_authentication_type.zig").HdfsAuthenticationType;
const HdfsNameNode = @import("hdfs_name_node.zig").HdfsNameNode;
const QopConfiguration = @import("qop_configuration.zig").QopConfiguration;

pub const UpdateLocationHdfsInput = struct {
    /// The Amazon Resource Names (ARNs) of the DataSync agents that can connect to
    /// your
    /// HDFS cluster.
    agent_arns: ?[]const []const u8 = null,

    /// The type of authentication used to determine the identity of the user.
    authentication_type: ?HdfsAuthenticationType = null,

    /// The size of the data blocks to write into the HDFS cluster.
    block_size: ?i32 = null,

    /// The Kerberos key table (keytab) that contains mappings between the defined
    /// Kerberos
    /// principal and the encrypted keys. You can load the keytab from a file by
    /// providing the file's
    /// address.
    kerberos_keytab: ?[]const u8 = null,

    /// The `krb5.conf` file that contains the Kerberos configuration information.
    /// You
    /// can load the `krb5.conf` file by providing the file's address. If you're
    /// using the
    /// CLI, it performs the base64 encoding for you. Otherwise, provide the
    /// base64-encoded text.
    kerberos_krb_5_conf: ?[]const u8 = null,

    /// The Kerberos principal with access to the files and folders on the HDFS
    /// cluster.
    kerberos_principal: ?[]const u8 = null,

    /// The URI of the HDFS cluster's Key Management Server (KMS).
    kms_key_provider_uri: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the source HDFS cluster location.
    location_arn: []const u8,

    /// The NameNode that manages the HDFS namespace. The NameNode performs
    /// operations such as
    /// opening, closing, and renaming files and directories. The NameNode contains
    /// the information to
    /// map blocks of data to the DataNodes. You can use only one NameNode.
    name_nodes: ?[]const HdfsNameNode = null,

    /// The Quality of Protection (QOP) configuration specifies the Remote Procedure
    /// Call (RPC)
    /// and data transfer privacy settings configured on the Hadoop Distributed File
    /// System (HDFS)
    /// cluster.
    qop_configuration: ?QopConfiguration = null,

    /// The number of DataNodes to replicate the data to when writing to the HDFS
    /// cluster.
    replication_factor: ?i32 = null,

    /// The user name used to identify the client on the host operating system.
    simple_user: ?[]const u8 = null,

    /// A subdirectory in the HDFS cluster. This subdirectory is used to read data
    /// from or write
    /// data to the HDFS cluster.
    subdirectory: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .authentication_type = "AuthenticationType",
        .block_size = "BlockSize",
        .kerberos_keytab = "KerberosKeytab",
        .kerberos_krb_5_conf = "KerberosKrb5Conf",
        .kerberos_principal = "KerberosPrincipal",
        .kms_key_provider_uri = "KmsKeyProviderUri",
        .location_arn = "LocationArn",
        .name_nodes = "NameNodes",
        .qop_configuration = "QopConfiguration",
        .replication_factor = "ReplicationFactor",
        .simple_user = "SimpleUser",
        .subdirectory = "Subdirectory",
    };
};

pub const UpdateLocationHdfsOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLocationHdfsInput, options: Options) !UpdateLocationHdfsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateLocationHdfsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "FmrsService.UpdateLocationHdfs");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateLocationHdfsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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

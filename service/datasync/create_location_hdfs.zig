const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const HdfsAuthenticationType = @import("hdfs_authentication_type.zig").HdfsAuthenticationType;
const CmkSecretConfig = @import("cmk_secret_config.zig").CmkSecretConfig;
const CustomSecretConfig = @import("custom_secret_config.zig").CustomSecretConfig;
const HdfsNameNode = @import("hdfs_name_node.zig").HdfsNameNode;
const QopConfiguration = @import("qop_configuration.zig").QopConfiguration;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationHdfsInput = struct {
    /// The Amazon Resource Names (ARNs) of the DataSync agents that can connect to
    /// your
    /// HDFS cluster.
    agent_arns: []const []const u8,

    /// The type of authentication used to determine the identity of the user.
    authentication_type: HdfsAuthenticationType,

    /// The size of data blocks to write into the HDFS cluster. The block size must
    /// be a multiple
    /// of 512 bytes. The default block size is 128 mebibytes (MiB).
    block_size: ?i32 = null,

    /// Specifies configuration information for a DataSync-managed secret, which
    /// includes the Kerberos keytab that DataSync uses to access a specific Hadoop
    /// Distributed File System (HDFS) storage location, with a
    /// customer-managed KMS key.
    ///
    /// When you include this parameter as part of a `CreateLocationHdfs` request,
    /// you provide only the KMS key ARN. DataSync uses this KMS key together with
    /// the `KerberosKeytab` you specify for
    /// to create a DataSync-managed secret to store the location access
    /// credentials.
    ///
    /// Make sure that DataSync has permission to access the KMS key that
    /// you specify. For more information, see [
    /// Using a service-managed secret encrypted with a custom KMS
    /// key](https://docs.aws.amazon.com/datasync/latest/userguide/location-credentials.html#service-secret-custom-key).
    ///
    /// You can use either `CmkSecretConfig` (with `KerberosKeytab`) or
    /// `CustomSecretConfig` (without `KerberosKeytab`) to provide
    /// credentials for a `CreateLocationHdfs` request. Do not provide both
    /// parameters for the same request.
    cmk_secret_config: ?CmkSecretConfig = null,

    /// Specifies configuration information for a customer-managed Secrets Manager
    /// secret where
    /// the Kerberos keytab for the HDFS storage location is stored in binary, in
    /// Secrets
    /// Manager. This configuration includes the secret ARN, and the ARN for an IAM
    /// role
    /// that provides access to the secret. For more information, see [
    /// Using a secret that you
    /// manage](https://docs.aws.amazon.com/datasync/latest/userguide/location-credentials.html#custom-secret-custom-key).
    ///
    /// You can use either `CmkSecretConfig` (with `KerberosKeytab`) or
    /// `CustomSecretConfig` (without `KerberosKeytab`) to provide
    /// credentials for a `CreateLocationHdfs` request. Do not provide both
    /// parameters for the same request.
    custom_secret_config: ?CustomSecretConfig = null,

    /// The Kerberos key table (keytab) that contains mappings between the defined
    /// Kerberos
    /// principal and the encrypted keys. You can load the keytab from a file by
    /// providing the file's
    /// address.
    ///
    /// If `KERBEROS` is specified for `AuthenticationType`, this
    /// parameter is required.
    kerberos_keytab: ?[]const u8 = null,

    /// The `krb5.conf` file that contains the Kerberos configuration information.
    /// You
    /// can load the `krb5.conf` file by providing the file's address. If you're
    /// using the
    /// CLI, it performs the base64 encoding for you. Otherwise, provide the
    /// base64-encoded text.
    ///
    /// If `KERBEROS` is specified for `AuthenticationType`, this
    /// parameter is required.
    kerberos_krb_5_conf: ?[]const u8 = null,

    /// The Kerberos principal with access to the files and folders on the HDFS
    /// cluster.
    ///
    /// If `KERBEROS` is specified for `AuthenticationType`, this
    /// parameter is required.
    kerberos_principal: ?[]const u8 = null,

    /// The URI of the HDFS cluster's Key Management Server (KMS).
    kms_key_provider_uri: ?[]const u8 = null,

    /// The NameNode that manages the HDFS namespace. The NameNode performs
    /// operations such as
    /// opening, closing, and renaming files and directories. The NameNode contains
    /// the information to
    /// map blocks of data to the DataNodes. You can use only one NameNode.
    name_nodes: []const HdfsNameNode,

    /// The Quality of Protection (QOP) configuration specifies the Remote Procedure
    /// Call (RPC)
    /// and data transfer protection settings configured on the Hadoop Distributed
    /// File System (HDFS)
    /// cluster. If `QopConfiguration` isn't specified, `RpcProtection` and
    /// `DataTransferProtection` default to `PRIVACY`. If you set
    /// `RpcProtection` or `DataTransferProtection`, the other parameter
    /// assumes the same value.
    qop_configuration: ?QopConfiguration = null,

    /// The number of DataNodes to replicate the data to when writing to the HDFS
    /// cluster. By
    /// default, data is replicated to three DataNodes.
    replication_factor: ?i32 = null,

    /// The user name used to identify the client on the host operating system.
    ///
    /// If `SIMPLE` is specified for `AuthenticationType`, this parameter
    /// is required.
    simple_user: ?[]const u8 = null,

    /// A subdirectory in the HDFS cluster. This subdirectory is used to read data
    /// from or write
    /// data to the HDFS cluster. If the subdirectory isn't specified, it will
    /// default to
    /// `/`.
    subdirectory: ?[]const u8 = null,

    /// The key-value pair that represents the tag that you want to add to the
    /// location. The value
    /// can be an empty string. We recommend using tags to name your resources.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .agent_arns = "AgentArns",
        .authentication_type = "AuthenticationType",
        .block_size = "BlockSize",
        .cmk_secret_config = "CmkSecretConfig",
        .custom_secret_config = "CustomSecretConfig",
        .kerberos_keytab = "KerberosKeytab",
        .kerberos_krb_5_conf = "KerberosKrb5Conf",
        .kerberos_principal = "KerberosPrincipal",
        .kms_key_provider_uri = "KmsKeyProviderUri",
        .name_nodes = "NameNodes",
        .qop_configuration = "QopConfiguration",
        .replication_factor = "ReplicationFactor",
        .simple_user = "SimpleUser",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationHdfsOutput = struct {
    /// The ARN of the source HDFS cluster location that you create.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationHdfsInput, options: CallOptions) !CreateLocationHdfsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLocationHdfsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateLocationHdfs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLocationHdfsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationHdfsOutput, body, allocator);
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

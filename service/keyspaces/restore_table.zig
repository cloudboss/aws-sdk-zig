const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoScalingSpecification = @import("auto_scaling_specification.zig").AutoScalingSpecification;
const CapacitySpecification = @import("capacity_specification.zig").CapacitySpecification;
const EncryptionSpecification = @import("encryption_specification.zig").EncryptionSpecification;
const PointInTimeRecovery = @import("point_in_time_recovery.zig").PointInTimeRecovery;
const ReplicaSpecification = @import("replica_specification.zig").ReplicaSpecification;
const Tag = @import("tag.zig").Tag;

pub const RestoreTableInput = struct {
    /// The optional auto scaling settings for the restored table in provisioned
    /// capacity mode. Specifies if the service can manage throughput capacity of a
    /// provisioned table automatically on your behalf. Amazon Keyspaces auto
    /// scaling helps you provision throughput capacity for variable workloads
    /// efficiently by increasing and decreasing your table's read and write
    /// capacity automatically in response to application traffic.
    ///
    /// For more information, see [Managing throughput capacity automatically with
    /// Amazon Keyspaces auto
    /// scaling](https://docs.aws.amazon.com/keyspaces/latest/devguide/autoscaling.html) in the *Amazon Keyspaces Developer Guide*.
    auto_scaling_specification: ?AutoScalingSpecification = null,

    /// Specifies the read/write throughput capacity mode for the target table. The
    /// options are:
    ///
    /// * `throughputMode:PAY_PER_REQUEST`
    /// * `throughputMode:PROVISIONED` - Provisioned capacity mode requires
    ///   `readCapacityUnits` and `writeCapacityUnits` as input.
    ///
    /// The default is `throughput_mode:PAY_PER_REQUEST`.
    ///
    /// For more information, see [Read/write capacity
    /// modes](https://docs.aws.amazon.com/keyspaces/latest/devguide/ReadWriteCapacityMode.html) in the *Amazon Keyspaces Developer Guide*.
    capacity_specification_override: ?CapacitySpecification = null,

    /// Specifies the encryption settings for the target table. You can choose one
    /// of the following KMS key (KMS key):
    ///
    /// * `type:AWS_OWNED_KMS_KEY` - This key is owned by Amazon Keyspaces.
    /// * `type:CUSTOMER_MANAGED_KMS_KEY` - This key is stored in your account and
    ///   is created, owned, and managed by you. This option requires the
    ///   `kms_key_identifier` of the KMS key in Amazon Resource Name (ARN) format
    ///   as input.
    ///
    /// The default is `type:AWS_OWNED_KMS_KEY`.
    ///
    /// For more information, see [Encryption at
    /// rest](https://docs.aws.amazon.com/keyspaces/latest/devguide/EncryptionAtRest.html) in the *Amazon Keyspaces Developer Guide*.
    encryption_specification_override: ?EncryptionSpecification = null,

    /// Specifies the `pointInTimeRecovery` settings for the target table. The
    /// options are:
    ///
    /// * `status=ENABLED`
    /// * `status=DISABLED`
    ///
    /// If it's not specified, the default is `status=DISABLED`.
    ///
    /// For more information, see [Point-in-time
    /// recovery](https://docs.aws.amazon.com/keyspaces/latest/devguide/PointInTimeRecovery.html) in the *Amazon Keyspaces Developer Guide*.
    point_in_time_recovery_override: ?PointInTimeRecovery = null,

    /// The optional Region specific settings of a multi-Regional table.
    replica_specifications: ?[]const ReplicaSpecification = null,

    /// The restore timestamp in ISO 8601 format.
    restore_timestamp: ?i64 = null,

    /// The keyspace name of the source table.
    source_keyspace_name: []const u8,

    /// The name of the source table.
    source_table_name: []const u8,

    /// A list of key-value pair tags to be attached to the restored table.
    ///
    /// For more information, see [Adding tags and labels to Amazon Keyspaces
    /// resources](https://docs.aws.amazon.com/keyspaces/latest/devguide/tagging-keyspaces.html) in the *Amazon Keyspaces Developer Guide*.
    tags_override: ?[]const Tag = null,

    /// The name of the target keyspace.
    target_keyspace_name: []const u8,

    /// The name of the target table.
    target_table_name: []const u8,

    pub const json_field_names = .{
        .auto_scaling_specification = "autoScalingSpecification",
        .capacity_specification_override = "capacitySpecificationOverride",
        .encryption_specification_override = "encryptionSpecificationOverride",
        .point_in_time_recovery_override = "pointInTimeRecoveryOverride",
        .replica_specifications = "replicaSpecifications",
        .restore_timestamp = "restoreTimestamp",
        .source_keyspace_name = "sourceKeyspaceName",
        .source_table_name = "sourceTableName",
        .tags_override = "tagsOverride",
        .target_keyspace_name = "targetKeyspaceName",
        .target_table_name = "targetTableName",
    };
};

pub const RestoreTableOutput = struct {
    /// The Amazon Resource Name (ARN) of the restored table.
    restored_table_arn: []const u8,

    pub const json_field_names = .{
        .restored_table_arn = "restoredTableARN",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreTableInput, options: CallOptions) !RestoreTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreTableInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "KeyspacesService.RestoreTable");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreTableOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(RestoreTableOutput, body, allocator);
}

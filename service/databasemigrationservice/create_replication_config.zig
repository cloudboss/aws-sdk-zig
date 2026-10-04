const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeConfig = @import("compute_config.zig").ComputeConfig;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const Tag = @import("tag.zig").Tag;
const ReplicationConfig = @import("replication_config.zig").ReplicationConfig;

pub const CreateReplicationConfigInput = struct {
    /// Configuration parameters for provisioning an DMS Serverless replication.
    compute_config: ComputeConfig,

    /// A unique identifier that you want to use to create a `ReplicationConfigArn`
    /// that is returned as part of the output from this action. You can then pass
    /// this output
    /// `ReplicationConfigArn` as the value of the `ReplicationConfigArn`
    /// option for other actions to identify both DMS Serverless replications and
    /// replication
    /// configurations that you want those actions to operate on. For some actions,
    /// you can also
    /// use either this unique identifier or a corresponding ARN in action filters
    /// to identify the
    /// specific replication and replication configuration to operate on.
    replication_config_identifier: []const u8,

    /// Optional JSON settings for DMS Serverless replications that are provisioned
    /// using this
    /// replication configuration. For example, see [ Change processing tuning
    /// settings](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TaskSettings.ChangeProcessingTuning.html).
    replication_settings: ?[]const u8 = null,

    /// The type of DMS Serverless replication to provision using this replication
    /// configuration.
    ///
    /// Possible values:
    ///
    /// * `"full-load"`
    ///
    /// * `"cdc"`
    ///
    /// * `"full-load-and-cdc"`
    replication_type: MigrationTypeValue,

    /// Optional unique value or name that you set for a given resource that can be
    /// used to
    /// construct an Amazon Resource Name (ARN) for that resource. For more
    /// information, see [ Fine-grained access control using resource names and
    /// tags](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.FineGrainedAccess).
    resource_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the source endpoint for this DMS
    /// Serverless
    /// replication configuration.
    source_endpoint_arn: []const u8,

    /// Optional JSON settings for specifying supplemental data. For more
    /// information, see
    /// [
    /// Specifying supplemental data for task
    /// settings](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.TaskData.html).
    supplemental_settings: ?[]const u8 = null,

    /// JSON table mappings for DMS Serverless replications that are provisioned
    /// using this
    /// replication configuration. For more information, see [ Specifying table
    /// selection and transformations rules using
    /// JSON](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tasks.CustomizingTasks.TableMapping.SelectionTransformation.html).
    table_mappings: []const u8,

    /// One or more optional tags associated with resources used by the DMS
    /// Serverless
    /// replication. For more information, see [ Tagging resources in Database
    /// Migration
    /// Service](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Tagging.html).
    tags: ?[]const Tag = null,

    /// The Amazon Resource Name (ARN) of the target endpoint for this DMS
    /// serverless
    /// replication configuration.
    target_endpoint_arn: []const u8,

    pub const json_field_names = .{
        .compute_config = "ComputeConfig",
        .replication_config_identifier = "ReplicationConfigIdentifier",
        .replication_settings = "ReplicationSettings",
        .replication_type = "ReplicationType",
        .resource_identifier = "ResourceIdentifier",
        .source_endpoint_arn = "SourceEndpointArn",
        .supplemental_settings = "SupplementalSettings",
        .table_mappings = "TableMappings",
        .tags = "Tags",
        .target_endpoint_arn = "TargetEndpointArn",
    };
};

pub const CreateReplicationConfigOutput = struct {
    /// Configuration parameters returned from the DMS Serverless replication after
    /// it is
    /// created.
    replication_config: ?ReplicationConfig = null,

    pub const json_field_names = .{
        .replication_config = "ReplicationConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationConfigInput, options: CallOptions) !CreateReplicationConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationConfigInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateReplicationConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateReplicationConfigOutput, body, allocator);
}

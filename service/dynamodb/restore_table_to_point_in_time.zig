const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingMode = @import("billing_mode.zig").BillingMode;
const GlobalSecondaryIndex = @import("global_secondary_index.zig").GlobalSecondaryIndex;
const LocalSecondaryIndex = @import("local_secondary_index.zig").LocalSecondaryIndex;
const OnDemandThroughput = @import("on_demand_throughput.zig").OnDemandThroughput;
const ProvisionedThroughput = @import("provisioned_throughput.zig").ProvisionedThroughput;
const SSESpecification = @import("sse_specification.zig").SSESpecification;
const VectorIndex = @import("vector_index.zig").VectorIndex;
const TableDescription = @import("table_description.zig").TableDescription;

pub const RestoreTableToPointInTimeInput = struct {
    /// The billing mode of the restored table.
    billing_mode_override: ?BillingMode = null,

    /// List of global secondary indexes for the restored table. The indexes
    /// provided should
    /// match existing secondary indexes. You can choose to exclude some or all of
    /// the indexes
    /// at the time of restore.
    ///
    /// The `WarmThroughput` setting is not supported on global secondary indexes
    /// when you use `RestoreTableToPointInTime`. Although `WarmThroughput`
    /// appears in the shared index definition, including it in a
    /// `GlobalSecondaryIndexOverride` entry causes the request to fail with a
    /// validation error.
    global_secondary_index_override: ?[]const GlobalSecondaryIndex = null,

    /// List of local secondary indexes for the restored table. The indexes provided
    /// should
    /// match existing secondary indexes. You can choose to exclude some or all of
    /// the indexes
    /// at the time of restore.
    local_secondary_index_override: ?[]const LocalSecondaryIndex = null,

    on_demand_throughput_override: ?OnDemandThroughput = null,

    /// Provisioned throughput settings for the restored table.
    provisioned_throughput_override: ?ProvisionedThroughput = null,

    /// Time in the past to restore the table to.
    restore_date_time: ?i64 = null,

    /// The DynamoDB table that will be restored. This value is an Amazon Resource
    /// Name
    /// (ARN).
    source_table_arn: ?[]const u8 = null,

    /// Name of the source table that is being restored.
    source_table_name: ?[]const u8 = null,

    /// The new server-side encryption settings for the restored table.
    sse_specification_override: ?SSESpecification = null,

    /// The name of the new table to which it must be restored to.
    target_table_name: []const u8,

    /// Restore the table to the latest possible time. `LatestRestorableDateTime`
    /// is typically 5 minutes before the current time.
    use_latest_restorable_time: ?bool = null,

    /// The vector indexes for the restored table. If not specified, all vector
    /// indexes
    /// from the source table are restored. The indexes provided must match existing
    /// vector indexes from the source table. You can choose to exclude some or all
    /// of
    /// the vector indexes at the time of restore.
    vector_index_override: ?[]const VectorIndex = null,

    pub const json_field_names = .{
        .billing_mode_override = "BillingModeOverride",
        .global_secondary_index_override = "GlobalSecondaryIndexOverride",
        .local_secondary_index_override = "LocalSecondaryIndexOverride",
        .on_demand_throughput_override = "OnDemandThroughputOverride",
        .provisioned_throughput_override = "ProvisionedThroughputOverride",
        .restore_date_time = "RestoreDateTime",
        .source_table_arn = "SourceTableArn",
        .source_table_name = "SourceTableName",
        .sse_specification_override = "SSESpecificationOverride",
        .target_table_name = "TargetTableName",
        .use_latest_restorable_time = "UseLatestRestorableTime",
        .vector_index_override = "VectorIndexOverride",
    };
};

pub const RestoreTableToPointInTimeOutput = struct {
    /// Represents the properties of a table.
    table_description: ?TableDescription = null,

    pub const json_field_names = .{
        .table_description = "TableDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RestoreTableToPointInTimeInput, options: CallOptions) !RestoreTableToPointInTimeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RestoreTableToPointInTimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.RestoreTableToPointInTime");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RestoreTableToPointInTimeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RestoreTableToPointInTimeOutput, body, allocator);
}

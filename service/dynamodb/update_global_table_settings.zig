const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BillingMode = @import("billing_mode.zig").BillingMode;
const GlobalTableGlobalSecondaryIndexSettingsUpdate = @import("global_table_global_secondary_index_settings_update.zig").GlobalTableGlobalSecondaryIndexSettingsUpdate;
const AutoScalingSettingsUpdate = @import("auto_scaling_settings_update.zig").AutoScalingSettingsUpdate;
const ReplicaSettingsUpdate = @import("replica_settings_update.zig").ReplicaSettingsUpdate;
const ReplicaSettingsDescription = @import("replica_settings_description.zig").ReplicaSettingsDescription;

pub const UpdateGlobalTableSettingsInput = struct {
    /// The billing mode of the global table. If `GlobalTableBillingMode` is not
    /// specified, the global table defaults to `PROVISIONED` capacity billing
    /// mode.
    ///
    /// * `PROVISIONED` - We recommend using `PROVISIONED` for
    /// predictable workloads. `PROVISIONED` sets the billing mode to [Provisioned
    /// capacity
    /// mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/provisioned-capacity-mode.html).
    ///
    /// * `PAY_PER_REQUEST` - We recommend using `PAY_PER_REQUEST`
    /// for unpredictable workloads. `PAY_PER_REQUEST` sets the billing mode
    /// to [On-demand capacity
    /// mode](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/on-demand-capacity-mode.html).
    global_table_billing_mode: ?BillingMode = null,

    /// Represents the settings of a global secondary index for a global table that
    /// will be
    /// modified.
    global_table_global_secondary_index_settings_update: ?[]const GlobalTableGlobalSecondaryIndexSettingsUpdate = null,

    /// The name of the global table
    global_table_name: []const u8,

    /// Auto scaling settings for managing provisioned write capacity for the global
    /// table.
    global_table_provisioned_write_capacity_auto_scaling_settings_update: ?AutoScalingSettingsUpdate = null,

    /// The maximum number of writes consumed per second before DynamoDB returns a
    /// `ThrottlingException.`
    global_table_provisioned_write_capacity_units: ?i64 = null,

    /// Represents the settings for a global table in a Region that will be
    /// modified.
    replica_settings_update: ?[]const ReplicaSettingsUpdate = null,

    pub const json_field_names = .{
        .global_table_billing_mode = "GlobalTableBillingMode",
        .global_table_global_secondary_index_settings_update = "GlobalTableGlobalSecondaryIndexSettingsUpdate",
        .global_table_name = "GlobalTableName",
        .global_table_provisioned_write_capacity_auto_scaling_settings_update = "GlobalTableProvisionedWriteCapacityAutoScalingSettingsUpdate",
        .global_table_provisioned_write_capacity_units = "GlobalTableProvisionedWriteCapacityUnits",
        .replica_settings_update = "ReplicaSettingsUpdate",
    };
};

pub const UpdateGlobalTableSettingsOutput = struct {
    /// The name of the global table.
    global_table_name: ?[]const u8 = null,

    /// The Region-specific settings for the global table.
    replica_settings: ?[]const ReplicaSettingsDescription = null,

    pub const json_field_names = .{
        .global_table_name = "GlobalTableName",
        .replica_settings = "ReplicaSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGlobalTableSettingsInput, options: CallOptions) !UpdateGlobalTableSettingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGlobalTableSettingsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.UpdateGlobalTableSettings");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGlobalTableSettingsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateGlobalTableSettingsOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const SourceDataSetting = @import("source_data_setting.zig").SourceDataSetting;
const TargetDataSetting = @import("target_data_setting.zig").TargetDataSetting;
const DataMigration = @import("data_migration.zig").DataMigration;

pub const ModifyDataMigrationInput = struct {
    /// The identifier (name or ARN) of the data migration to modify.
    data_migration_identifier: []const u8,

    /// The new name for the data migration.
    data_migration_name: ?[]const u8 = null,

    /// The new migration type for the data migration.
    data_migration_type: ?MigrationTypeValue = null,

    /// Whether to enable Cloudwatch logs for the data migration.
    enable_cloudwatch_logs: ?bool = null,

    /// The number of parallel jobs that trigger parallel threads to unload the
    /// tables from the
    /// source, and then load them to the target.
    number_of_jobs: ?i32 = null,

    /// A JSON-formatted string that defines what objects to include and exclude
    /// from the
    /// migration.
    selection_rules: ?[]const u8 = null,

    /// The new service access role ARN for the data migration.
    service_access_role_arn: ?[]const u8 = null,

    /// The new information about the source data provider for the data migration.
    source_data_settings: ?[]const SourceDataSetting = null,

    /// The new information about the target data provider for the data migration.
    target_data_settings: ?[]const TargetDataSetting = null,

    pub const json_field_names = .{
        .data_migration_identifier = "DataMigrationIdentifier",
        .data_migration_name = "DataMigrationName",
        .data_migration_type = "DataMigrationType",
        .enable_cloudwatch_logs = "EnableCloudwatchLogs",
        .number_of_jobs = "NumberOfJobs",
        .selection_rules = "SelectionRules",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .source_data_settings = "SourceDataSettings",
        .target_data_settings = "TargetDataSettings",
    };
};

pub const ModifyDataMigrationOutput = struct {
    /// Information about the modified data migration.
    data_migration: ?DataMigration = null,

    pub const json_field_names = .{
        .data_migration = "DataMigration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyDataMigrationInput, options: CallOptions) !ModifyDataMigrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyDataMigrationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyDataMigration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyDataMigrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyDataMigrationOutput, body, allocator);
}

const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const SourceDataSetting = @import("source_data_setting.zig").SourceDataSetting;
const Tag = @import("tag.zig").Tag;
const TargetDataSetting = @import("target_data_setting.zig").TargetDataSetting;
const DataMigration = @import("data_migration.zig").DataMigration;

pub const CreateDataMigrationInput = struct {
    /// A user-friendly name for the data migration. Data migration names have the
    /// following
    /// constraints:
    ///
    /// * Must begin with a letter, and can only contain ASCII letters, digits, and
    ///   hyphens.
    ///
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// * Length must be from 1 to 255 characters.
    data_migration_name: ?[]const u8 = null,

    /// Specifies if the data migration is full-load only, change data capture (CDC)
    /// only, or
    /// full-load and CDC.
    data_migration_type: MigrationTypeValue,

    /// Specifies whether to enable CloudWatch logs for the data migration.
    enable_cloudwatch_logs: ?bool = null,

    /// An identifier for the migration project.
    migration_project_identifier: []const u8,

    /// The number of parallel jobs that trigger parallel threads to unload the
    /// tables from the
    /// source, and then load them to the target.
    number_of_jobs: ?i32 = null,

    /// An optional JSON string specifying what tables, views, and schemas to
    /// include or exclude
    /// from the migration.
    selection_rules: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the service access role that you want to
    /// use to
    /// create the data migration.
    service_access_role_arn: []const u8,

    /// Specifies information about the source data provider.
    source_data_settings: ?[]const SourceDataSetting = null,

    /// One or more tags to be assigned to the data migration.
    tags: ?[]const Tag = null,

    /// Specifies information about the target data provider.
    target_data_settings: ?[]const TargetDataSetting = null,

    pub const json_field_names = .{
        .data_migration_name = "DataMigrationName",
        .data_migration_type = "DataMigrationType",
        .enable_cloudwatch_logs = "EnableCloudwatchLogs",
        .migration_project_identifier = "MigrationProjectIdentifier",
        .number_of_jobs = "NumberOfJobs",
        .selection_rules = "SelectionRules",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .source_data_settings = "SourceDataSettings",
        .tags = "Tags",
        .target_data_settings = "TargetDataSettings",
    };
};

pub const CreateDataMigrationOutput = struct {
    /// Information about the created data migration.
    data_migration: ?DataMigration = null,

    pub const json_field_names = .{
        .data_migration = "DataMigration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataMigrationInput, options: CallOptions) !CreateDataMigrationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataMigrationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateDataMigration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataMigrationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDataMigrationOutput, body, allocator);
}

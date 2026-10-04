const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CharacterSet = @import("character_set.zig").CharacterSet;
const CustomDBEngineVersionAMI = @import("custom_db_engine_version_ami.zig").CustomDBEngineVersionAMI;
const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;
const Timezone = @import("timezone.zig").Timezone;
const Tag = @import("tag.zig").Tag;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;
const serde = @import("serde.zig");

pub const DeleteCustomDBEngineVersionInput = struct {
    /// The database engine.
    ///
    /// RDS Custom for Oracle supports the following values:
    ///
    /// * `custom-oracle-ee`
    /// * `custom-oracle-ee-cdb`
    /// * `custom-oracle-se2`
    /// * `custom-oracle-se2-cdb`
    ///
    /// RDS Custom for SQL Server supports the following values:
    ///
    /// * `custom-sqlserver-ee`
    /// * `custom-sqlserver-se`
    /// * `custom-sqlserver-web`
    /// * `custom-sqlserver-dev`
    ///
    /// RDS for SQL Server supports the following values:
    ///
    /// * `sqlserver-ee` (Bring Your Own Media)
    /// * `sqlserver-se` (Bring Your Own Media)
    /// * `sqlserver-dev-ee`
    engine: []const u8,

    /// The custom engine version (CEV) for your DB instance. This option is
    /// required for RDS Custom, but optional for Amazon RDS. The combination of
    /// `Engine` and `EngineVersion` is unique per customer per Amazon Web Services
    /// Region.
    engine_version: []const u8,
};

pub const DeleteCustomDBEngineVersionOutput = @import("db_engine_version.zig").DBEngineVersion;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteCustomDBEngineVersionInput, options: CallOptions) !DeleteCustomDBEngineVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteCustomDBEngineVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DeleteCustomDBEngineVersion&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    try body_buf.appendSlice(allocator, "&EngineVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine_version);

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteCustomDBEngineVersionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DeleteCustomDBEngineVersionResult")) break;
            },
            else => {},
        }
    }

    var result: DeleteCustomDBEngineVersionOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateTime")) {
                    result.create_time = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "CustomDBEngineVersionManifest")) {
                    result.custom_db_engine_version_manifest = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFiles")) {
                    result.database_installation_files = try serde.deserializeStringList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFilesS3BucketName")) {
                    result.database_installation_files_s3_bucket_name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatabaseInstallationFilesS3Prefix")) {
                    result.database_installation_files_s3_prefix = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineDescription")) {
                    result.db_engine_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineMediaType")) {
                    result.db_engine_media_type = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionArn")) {
                    result.db_engine_version_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBEngineVersionDescription")) {
                    result.db_engine_version_description = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DBParameterGroupFamily")) {
                    result.db_parameter_group_family = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DefaultCharacterSet")) {
                    result.default_character_set = try serde.deserializeCharacterSet(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Engine")) {
                    result.engine = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "EngineVersion")) {
                    result.engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ExportableLogTypes")) {
                    result.exportable_log_types = try serde.deserializeLogTypeList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "FailureReason")) {
                    result.failure_reason = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "Image")) {
                    result.image = try serde.deserializeCustomDBEngineVersionAMI(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "KMSKeyId")) {
                    result.kms_key_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "MajorEngineVersion")) {
                    result.major_engine_version = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ServerlessV2FeaturesSupport")) {
                    result.serverless_v2_features_support = try serde.deserializeServerlessV2FeaturesSupport(allocator, &reader);
                } else if (std.mem.eql(u8, e.local, "Status")) {
                    result.status = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "SupportedCACertificateIdentifiers")) {
                    result.supported_ca_certificate_identifiers = try serde.deserializeCACertificateIdentifiersList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedCharacterSets")) {
                    result.supported_character_sets = try serde.deserializeSupportedCharacterSetsList(allocator, &reader, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedEngineModes")) {
                    result.supported_engine_modes = try serde.deserializeEngineModeList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedFeatureNames")) {
                    result.supported_feature_names = try serde.deserializeFeatureNameList(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "SupportedNcharCharacterSets")) {
                    result.supported_nchar_character_sets = try serde.deserializeSupportedCharacterSetsList(allocator, &reader, "CharacterSet");
                } else if (std.mem.eql(u8, e.local, "SupportedTimezones")) {
                    result.supported_timezones = try serde.deserializeSupportedTimezonesList(allocator, &reader, "Timezone");
                } else if (std.mem.eql(u8, e.local, "SupportsBabelfish")) {
                    result.supports_babelfish = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsCertificateRotationWithoutRestart")) {
                    result.supports_certificate_rotation_without_restart = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsGlobalDatabases")) {
                    result.supports_global_databases = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsIntegrations")) {
                    result.supports_integrations = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLimitlessDatabase")) {
                    result.supports_limitless_database = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLocalWriteForwarding")) {
                    result.supports_local_write_forwarding = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsLogExportsToCloudwatchLogs")) {
                    result.supports_log_exports_to_cloudwatch_logs = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsParallelQuery")) {
                    result.supports_parallel_query = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "SupportsReadReplica")) {
                    result.supports_read_replica = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "TagList")) {
                    result.tag_list = try serde.deserializeTagList(allocator, &reader, "Tag");
                } else if (std.mem.eql(u8, e.local, "ValidUpgradeTarget")) {
                    result.valid_upgrade_target = try serde.deserializeValidUpgradeTargetList(allocator, &reader, "UpgradeTarget");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

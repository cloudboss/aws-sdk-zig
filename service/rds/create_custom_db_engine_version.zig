const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const CharacterSet = @import("character_set.zig").CharacterSet;
const CustomDBEngineVersionAMI = @import("custom_db_engine_version_ami.zig").CustomDBEngineVersionAMI;
const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;
const Timezone = @import("timezone.zig").Timezone;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;
const serde = @import("serde.zig");

pub const CreateCustomDBEngineVersionInput = struct {
    /// The database installation files (ISO and EXE) uploaded to Amazon S3 for your
    /// database engine version to import to Amazon RDS.
    ///
    /// For RDS for SQL Server Bring Your Own Media (`sqlserver-ee`,
    /// `sqlserver-se`), provide the SQL Server RTM ISO file once per major version
    /// and edition combination. Minor versions reuse the same file.
    database_installation_files: ?[]const []const u8 = null,

    /// The name of an Amazon S3 bucket that contains database installation files
    /// for your CEV. For example, a valid bucket name is
    /// `my-custom-installation-files`.
    database_installation_files_s3_bucket_name: ?[]const u8 = null,

    /// The Amazon S3 directory that contains the database installation files for
    /// your CEV. For example, a valid bucket name is `123456789012/cev1`. If this
    /// setting isn't specified, no prefix is assumed.
    database_installation_files_s3_prefix: ?[]const u8 = null,

    /// An optional description of your CEV.
    description: ?[]const u8 = null,

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

    /// The name of your custom engine version (CEV).
    ///
    /// For RDS Custom for Oracle, the name format is `19.*customized_string*`. For
    /// example, a valid CEV name is `19.my_cev1`.
    ///
    /// For RDS Custom for SQL Server and RDS for SQL Server `sqlserver-dev-ee`, the
    /// name format is
    /// `*major_engine_version*.*minor_engine_version*.*customized_string*`. For
    /// example, a valid CEV name is `16.00.4215.2.my_cev1`.
    ///
    /// For RDS for SQL Server Bring Your Own Media (`sqlserver-ee`,
    /// `sqlserver-se`), specify the RDS engine version that you want to use. For
    /// example, `16.00.4175.1.v1`.
    ///
    /// The CEV name is unique per customer per Amazon Web Services Regions.
    engine_version: []const u8,

    /// The ID of the Amazon Machine Image (AMI). For RDS Custom for SQL Server, an
    /// AMI ID is required to create a CEV. For RDS Custom for Oracle, the default
    /// is the most recent AMI available, but you can specify an AMI ID that was
    /// used in a different Oracle CEV. Find the AMIs used by your CEVs by calling
    /// the
    /// [DescribeDBEngineVersions](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBEngineVersions.html) operation.
    image_id: ?[]const u8 = null,

    /// The Amazon Web Services KMS key identifier for an encrypted CEV. A symmetric
    /// encryption KMS key is required for RDS Custom, but optional for Amazon RDS.
    ///
    /// If you have an existing symmetric encryption KMS key in your account, you
    /// can use it with RDS Custom. No further action is necessary. If you don't
    /// already have a symmetric encryption KMS key in your account, follow the
    /// instructions in [ Creating a symmetric encryption KMS
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html#create-symmetric-cmk) in the *Amazon Web Services Key Management Service Developer Guide*.
    ///
    /// You can choose the same symmetric encryption key when you create a CEV and a
    /// DB instance, or choose different keys.
    kms_key_id: ?[]const u8 = null,

    /// The CEV manifest, which is a JSON document that describes the installation
    /// .zip files stored in Amazon S3. Specify the name/value pairs in a file or a
    /// quoted string. RDS Custom applies the patches in the order in which they are
    /// listed.
    ///
    /// The following JSON fields are valid:
    ///
    /// **MediaImportTemplateVersion**
    ///
    /// Version of the CEV manifest. The date is in the format `YYYY-MM-DD`.
    ///
    /// **databaseInstallationFileNames**
    ///
    /// Ordered list of installation files for the CEV.
    ///
    /// **opatchFileNames**
    ///
    /// Ordered list of OPatch installers used for the Oracle DB engine.
    ///
    /// **psuRuPatchFileNames**
    ///
    /// The PSU and RU patches for this CEV.
    ///
    /// **OtherPatchFileNames**
    ///
    /// The patches that are not in the list of PSU and RU patches. Amazon RDS
    /// applies these patches after applying the PSU and RU patches.
    ///
    /// For more information, see [ Creating the CEV
    /// manifest](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/custom-cev.html#custom-cev.preparing.manifest) in the *Amazon RDS User Guide*.
    manifest: ?[]const u8 = null,

    /// The ARN of a CEV to use as a source for creating a new CEV. You can specify
    /// a different Amazon Machine Imagine (AMI) by using either `Source` or
    /// `UseAwsProvidedLatestImage`. You can't specify a different JSON manifest
    /// when you specify `SourceCustomDbEngineVersionIdentifier`.
    source_custom_db_engine_version_identifier: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    /// Specifies whether to use the latest service-provided Amazon Machine Image
    /// (AMI) for the CEV. If you specify `UseAwsProvidedLatestImage`, you can't
    /// also specify `ImageId`.
    use_aws_provided_latest_image: ?bool = null,
};

pub const CreateCustomDBEngineVersionOutput = @import("db_engine_version.zig").DBEngineVersion;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomDBEngineVersionInput, options: CallOptions) !CreateCustomDBEngineVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomDBEngineVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateCustomDBEngineVersion&Version=2014-10-31");
    if (input.database_installation_files) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&DatabaseInstallationFiles.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.database_installation_files_s3_bucket_name) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseInstallationFilesS3BucketName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.database_installation_files_s3_prefix) |v| {
        try body_buf.appendSlice(allocator, "&DatabaseInstallationFilesS3Prefix=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.description) |v| {
        try body_buf.appendSlice(allocator, "&Description=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Engine=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine);
    try body_buf.appendSlice(allocator, "&EngineVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine_version);
    if (input.image_id) |v| {
        try body_buf.appendSlice(allocator, "&ImageId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.kms_key_id) |v| {
        try body_buf.appendSlice(allocator, "&KMSKeyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.manifest) |v| {
        try body_buf.appendSlice(allocator, "&Manifest=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.source_custom_db_engine_version_identifier) |v| {
        try body_buf.appendSlice(allocator, "&SourceCustomDbEngineVersionIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.use_aws_provided_latest_image) |v| {
        try body_buf.appendSlice(allocator, "&UseAwsProvidedLatestImage=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomDBEngineVersionOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateCustomDBEngineVersionResult")) break;
            },
            else => {},
        }
    }

    var result: CreateCustomDBEngineVersionOutput = .{};
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

const ServerlessV2FeaturesSupport = @import("serverless_v2_features_support.zig").ServerlessV2FeaturesSupport;
const UpgradeTarget = @import("upgrade_target.zig").UpgradeTarget;

/// Detailed information about an engine version.
pub const DBEngineVersion = struct {
    /// The description of the database engine.
    db_engine_description: ?[]const u8,

    /// The description of the database engine version.
    db_engine_version_description: ?[]const u8,

    /// The name of the parameter group family for the database engine.
    db_parameter_group_family: ?[]const u8,

    /// The name of the database engine.
    engine: ?[]const u8,

    /// The version number of the database engine.
    engine_version: ?[]const u8,

    /// The types of logs that the database engine has available for export to
    /// Amazon
    /// CloudWatch Logs.
    exportable_log_types: ?[]const []const u8,

    /// Specifies any Amazon DocumentDB Serverless properties or limits that differ
    /// between Amazon DocumentDB engine versions.
    /// You can test the values of this attribute when deciding which Amazon
    /// DocumentDB version to use in a new or upgraded cluster.
    /// You can also retrieve the version of an existing cluster and check whether
    /// that version supports certain Amazon DocumentDB Serverless features before
    /// you attempt to use those features.
    serverless_v2_features_support: ?ServerlessV2FeaturesSupport,

    /// A list of the supported CA certificate identifiers.
    ///
    /// For more information, see [Updating Your Amazon DocumentDB TLS
    /// Certificates](https://docs.aws.amazon.com/documentdb/latest/developerguide/ca_cert_rotation.html) and
    /// [
    /// Encrypting Data in
    /// Transit](https://docs.aws.amazon.com/documentdb/latest/developerguide/security.encryption.ssl.html) in the *Amazon DocumentDB Developer
    /// Guide*.
    supported_ca_certificate_identifiers: ?[]const []const u8,

    /// Indicates whether the engine version supports rotating the server
    /// certificate without
    /// rebooting the DB instance.
    supports_certificate_rotation_without_restart: ?bool,

    /// A value that indicates whether the engine version supports exporting the log
    /// types
    /// specified by `ExportableLogTypes` to CloudWatch Logs.
    supports_log_exports_to_cloudwatch_logs: ?bool,

    /// A list of engine versions that this database engine version can be upgraded
    /// to.
    valid_upgrade_target: ?[]const UpgradeTarget,
};

const CatalogTarget = @import("catalog_target.zig").CatalogTarget;
const DeltaTarget = @import("delta_target.zig").DeltaTarget;
const DynamoDBTarget = @import("dynamo_db_target.zig").DynamoDBTarget;
const HudiTarget = @import("hudi_target.zig").HudiTarget;
const IcebergTarget = @import("iceberg_target.zig").IcebergTarget;
const JdbcTarget = @import("jdbc_target.zig").JdbcTarget;
const MongoDBTarget = @import("mongo_db_target.zig").MongoDBTarget;
const S3Target = @import("s3_target.zig").S3Target;

/// Specifies data stores to crawl.
pub const CrawlerTargets = struct {
    /// Specifies Glue Data Catalog targets.
    catalog_targets: ?[]const CatalogTarget = null,

    /// Specifies Delta data store targets.
    delta_targets: ?[]const DeltaTarget = null,

    /// Specifies Amazon DynamoDB targets.
    dynamo_db_targets: ?[]const DynamoDBTarget = null,

    /// Specifies Apache Hudi data store targets.
    hudi_targets: ?[]const HudiTarget = null,

    /// Specifies Apache Iceberg data store targets.
    iceberg_targets: ?[]const IcebergTarget = null,

    /// Specifies JDBC targets.
    jdbc_targets: ?[]const JdbcTarget = null,

    /// Specifies Amazon DocumentDB or MongoDB targets.
    mongo_db_targets: ?[]const MongoDBTarget = null,

    /// Specifies Amazon Simple Storage Service (Amazon S3) targets.
    s3_targets: ?[]const S3Target = null,

    pub const json_field_names = .{
        .catalog_targets = "CatalogTargets",
        .delta_targets = "DeltaTargets",
        .dynamo_db_targets = "DynamoDBTargets",
        .hudi_targets = "HudiTargets",
        .iceberg_targets = "IcebergTargets",
        .jdbc_targets = "JdbcTargets",
        .mongo_db_targets = "MongoDBTargets",
        .s3_targets = "S3Targets",
    };
};

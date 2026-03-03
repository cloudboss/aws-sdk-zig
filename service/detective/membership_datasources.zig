const aws = @import("aws");

const TimestampForCollection = @import("timestamp_for_collection.zig").TimestampForCollection;

/// Details on data source packages for members of the behavior graph.
pub const MembershipDatasources = struct {
    /// The account identifier of the Amazon Web Services account.
    account_id: ?[]const u8 = null,

    /// Details on when a data source package was added to a behavior graph.
    datasource_package_ingest_history: ?[]const aws.map.MapEntry([]const aws.map.MapEntry(TimestampForCollection)) = null,

    /// The ARN of the organization behavior graph.
    graph_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .datasource_package_ingest_history = "DatasourcePackageIngestHistory",
        .graph_arn = "GraphArn",
    };
};

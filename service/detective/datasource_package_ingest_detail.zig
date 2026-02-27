const aws = @import("aws");

const DatasourcePackageIngestState = @import("datasource_package_ingest_state.zig").DatasourcePackageIngestState;
const TimestampForCollection = @import("timestamp_for_collection.zig").TimestampForCollection;

/// Details about the data source packages ingested by your behavior graph.
pub const DatasourcePackageIngestDetail = struct {
    /// Details on which data source packages are ingested for a member account.
    datasource_package_ingest_state: ?DatasourcePackageIngestState,

    /// The date a data source package was enabled for this account
    last_ingest_state_change: ?[]const aws.map.MapEntry(TimestampForCollection),

    pub const json_field_names = .{
        .datasource_package_ingest_state = "DatasourcePackageIngestState",
        .last_ingest_state_change = "LastIngestStateChange",
    };
};

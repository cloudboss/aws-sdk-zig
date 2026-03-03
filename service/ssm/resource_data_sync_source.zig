const ResourceDataSyncAwsOrganizationsSource = @import("resource_data_sync_aws_organizations_source.zig").ResourceDataSyncAwsOrganizationsSource;

/// Information about the source of the data included in the resource data sync.
pub const ResourceDataSyncSource = struct {
    /// Information about the `AwsOrganizationsSource` resource data sync source. A
    /// sync
    /// source of this type can synchronize data from Organizations.
    aws_organizations_source: ?ResourceDataSyncAwsOrganizationsSource = null,

    /// When you create a resource data sync, if you choose one of the Organizations
    /// options, then Systems Manager
    /// automatically enables all OpsData sources in the selected Amazon Web
    /// Services Regions for all Amazon Web Services accounts in
    /// your organization (or in the selected organization units). For more
    /// information, see [Setting up Systems Manager Explorer to display data from
    /// multiple accounts and
    /// Regions](https://docs.aws.amazon.com/systems-manager/latest/userguide/Explorer-resource-data-sync.html) in
    /// the *Amazon Web Services Systems Manager User Guide*.
    enable_all_ops_data_sources: bool = false,

    /// Whether to automatically synchronize and aggregate data from new Amazon Web
    /// Services Regions when those
    /// Regions come online.
    include_future_regions: bool = false,

    /// The `SyncSource` Amazon Web Services Regions included in the resource data
    /// sync.
    source_regions: []const []const u8,

    /// The type of data source for the resource data sync. `SourceType` is either
    /// `AwsOrganizations` (if an organization is present in Organizations) or
    /// `SingleAccountMultiRegions`.
    source_type: []const u8,

    pub const json_field_names = .{
        .aws_organizations_source = "AwsOrganizationsSource",
        .enable_all_ops_data_sources = "EnableAllOpsDataSources",
        .include_future_regions = "IncludeFutureRegions",
        .source_regions = "SourceRegions",
        .source_type = "SourceType",
    };
};

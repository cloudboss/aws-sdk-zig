const ResourceDataSyncAwsOrganizationsSource = @import("resource_data_sync_aws_organizations_source.zig").ResourceDataSyncAwsOrganizationsSource;

/// The data type name for including resource data sync state. There are four
/// sync
/// states:
///
/// `OrganizationNotExists` (Your organization doesn't exist)
///
/// `NoPermissions` (The system can't locate the service-linked role. This role
/// is
/// automatically created when a user creates a resource data sync in Amazon Web
/// Services Systems Manager Explorer.)
///
/// `InvalidOrganizationalUnit` (You specified or selected an invalid unit in
/// the
/// resource data sync configuration.)
///
/// `TrustedAccessDisabled` (You disabled Systems Manager access in the
/// organization in
/// Organizations.)
pub const ResourceDataSyncSourceWithState = struct {
    /// The field name in `SyncSource` for the
    /// `ResourceDataSyncAwsOrganizationsSource` type.
    aws_organizations_source: ?ResourceDataSyncAwsOrganizationsSource,

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
    source_regions: ?[]const []const u8,

    /// The type of data source for the resource data sync. `SourceType` is either
    /// `AwsOrganizations` (if an organization is present in Organizations) or
    /// `singleAccountMultiRegions`.
    source_type: ?[]const u8,

    /// The data type name for including resource data sync state. There are four
    /// sync
    /// states:
    ///
    /// `OrganizationNotExists`: Your organization doesn't exist.
    ///
    /// `NoPermissions`: The system can't locate the service-linked role. This role
    /// is
    /// automatically created when a user creates a resource data sync in Explorer.
    ///
    /// `InvalidOrganizationalUnit`: You specified or selected an invalid unit in
    /// the
    /// resource data sync configuration.
    ///
    /// `TrustedAccessDisabled`: You disabled Systems Manager access in the
    /// organization in
    /// Organizations.
    state: ?[]const u8,

    pub const json_field_names = .{
        .aws_organizations_source = "AwsOrganizationsSource",
        .enable_all_ops_data_sources = "EnableAllOpsDataSources",
        .include_future_regions = "IncludeFutureRegions",
        .source_regions = "SourceRegions",
        .source_type = "SourceType",
        .state = "State",
    };
};

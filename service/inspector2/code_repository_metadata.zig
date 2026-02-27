const CodeRepositoryOnDemandScan = @import("code_repository_on_demand_scan.zig").CodeRepositoryOnDemandScan;
const ProjectCodeSecurityScanConfiguration = @import("project_code_security_scan_configuration.zig").ProjectCodeSecurityScanConfiguration;

/// Contains metadata information about a code repository that is being scanned
/// by Amazon
/// Inspector.
pub const CodeRepositoryMetadata = struct {
    /// The Amazon Resource Name (ARN) of the code security integration associated
    /// with the
    /// repository.
    integration_arn: ?[]const u8,

    /// The ID of the last commit that was scanned in the repository.
    last_scanned_commit_id: ?[]const u8,

    /// Information about on-demand scans performed on the repository.
    on_demand_scan: ?CodeRepositoryOnDemandScan,

    /// The name of the project in the code repository.
    project_name: []const u8,

    /// The type of repository provider (such as GitHub, GitLab, etc.).
    provider_type: []const u8,

    /// The visibility setting of the repository (public or private).
    provider_type_visibility: []const u8,

    /// The scan configuration settings applied to the code repository.
    scan_configuration: ?ProjectCodeSecurityScanConfiguration,

    pub const json_field_names = .{
        .integration_arn = "integrationArn",
        .last_scanned_commit_id = "lastScannedCommitId",
        .on_demand_scan = "onDemandScan",
        .project_name = "projectName",
        .provider_type = "providerType",
        .provider_type_visibility = "providerTypeVisibility",
        .scan_configuration = "scanConfiguration",
    };
};

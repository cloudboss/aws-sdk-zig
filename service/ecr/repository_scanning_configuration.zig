const ScanningRepositoryFilter = @import("scanning_repository_filter.zig").ScanningRepositoryFilter;
const ScanFrequency = @import("scan_frequency.zig").ScanFrequency;

/// The details of the scanning configuration for a repository.
pub const RepositoryScanningConfiguration = struct {
    /// The scan filters applied to the repository.
    applied_scan_filters: ?[]const ScanningRepositoryFilter = null,

    /// The ARN of the repository.
    repository_arn: ?[]const u8 = null,

    /// The name of the repository.
    repository_name: ?[]const u8 = null,

    /// The scan frequency for the repository.
    scan_frequency: ?ScanFrequency = null,

    /// Whether or not scan on push is configured for the repository.
    scan_on_push: bool = false,

    pub const json_field_names = .{
        .applied_scan_filters = "appliedScanFilters",
        .repository_arn = "repositoryArn",
        .repository_name = "repositoryName",
        .scan_frequency = "scanFrequency",
        .scan_on_push = "scanOnPush",
    };
};

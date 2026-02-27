const ScanningRepositoryFilter = @import("scanning_repository_filter.zig").ScanningRepositoryFilter;
const ScanFrequency = @import("scan_frequency.zig").ScanFrequency;

/// The details of a scanning rule for a private registry.
pub const RegistryScanningRule = struct {
    /// The repository filters associated with the scanning configuration for a
    /// private
    /// registry.
    repository_filters: []const ScanningRepositoryFilter,

    /// The frequency that scans are performed at for a private registry. When the
    /// `ENHANCED` scan type is specified, the supported scan frequencies are
    /// `CONTINUOUS_SCAN` and `SCAN_ON_PUSH`. When the
    /// `BASIC` scan type is specified, the `SCAN_ON_PUSH` scan
    /// frequency is supported. If scan on push is not specified, then the `MANUAL`
    /// scan frequency is set by default.
    scan_frequency: ScanFrequency,

    pub const json_field_names = .{
        .repository_filters = "repositoryFilters",
        .scan_frequency = "scanFrequency",
    };
};

const EcrScanFrequency = @import("ecr_scan_frequency.zig").EcrScanFrequency;

/// Information on the Amazon ECR repository metadata associated with a finding.
pub const EcrRepositoryMetadata = struct {
    /// The name of the Amazon ECR repository.
    name: ?[]const u8 = null,

    /// The frequency of scans.
    scan_frequency: ?EcrScanFrequency = null,

    pub const json_field_names = .{
        .name = "name",
        .scan_frequency = "scanFrequency",
    };
};

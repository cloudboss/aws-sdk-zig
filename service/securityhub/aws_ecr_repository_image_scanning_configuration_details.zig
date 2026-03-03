/// The image scanning configuration for a repository.
pub const AwsEcrRepositoryImageScanningConfigurationDetails = struct {
    /// Whether to scan images after they are pushed to a repository.
    scan_on_push: ?bool = null,

    pub const json_field_names = .{
        .scan_on_push = "ScanOnPush",
    };
};

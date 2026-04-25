/// Contains information about the incremental scan configuration.
pub const IncrementalScanDetails = struct {
    /// Amazon Resource Name (ARN) of the baseline resource used for incremental
    /// scanning. The scan will only process changes since this baseline resource
    /// was created.
    baseline_resource_arn: []const u8,

    pub const json_field_names = .{
        .baseline_resource_arn = "BaselineResourceArn",
    };
};

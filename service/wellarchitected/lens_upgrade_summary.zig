/// Lens upgrade summary return object.
pub const LensUpgradeSummary = struct {
    /// The current version of the lens.
    current_lens_version: ?[]const u8,

    /// The latest version of the lens.
    latest_lens_version: ?[]const u8,

    lens_alias: ?[]const u8,

    /// The ARN for the lens.
    lens_arn: ?[]const u8,

    /// `ResourceArn` of the lens being upgraded
    resource_arn: ?[]const u8,

    resource_name: ?[]const u8,

    workload_id: ?[]const u8,

    workload_name: ?[]const u8,

    pub const json_field_names = .{
        .current_lens_version = "CurrentLensVersion",
        .latest_lens_version = "LatestLensVersion",
        .lens_alias = "LensAlias",
        .lens_arn = "LensArn",
        .resource_arn = "ResourceArn",
        .resource_name = "ResourceName",
        .workload_id = "WorkloadId",
        .workload_name = "WorkloadName",
    };
};

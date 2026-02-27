const Tag = @import("tag.zig").Tag;

/// **[Default policies only]** Specifies exclusion parameters for volumes or
/// instances for which you
/// do not want to create snapshots or AMIs. The policy will not create
/// snapshots or AMIs
/// for target resources that match any of the specified exclusion parameters.
pub const Exclusions = struct {
    /// **[Default policies for EBS snapshots only]** Indicates whether to exclude
    /// volumes that are attached to
    /// instances as the boot volume. If you exclude boot volumes, only volumes
    /// attached as data
    /// (non-boot) volumes will be backed up by the policy. To exclude boot volumes,
    /// specify
    /// `true`.
    exclude_boot_volumes: ?bool,

    /// **[Default policies for EBS-backed AMIs only]** Specifies whether to exclude
    /// volumes that have specific tags.
    exclude_tags: ?[]const Tag,

    /// **[Default policies for EBS snapshots only]** Specifies the volume types to
    /// exclude. Volumes of the specified
    /// types will not be targeted by the policy.
    exclude_volume_types: ?[]const []const u8,

    pub const json_field_names = .{
        .exclude_boot_volumes = "ExcludeBootVolumes",
        .exclude_tags = "ExcludeTags",
        .exclude_volume_types = "ExcludeVolumeTypes",
    };
};

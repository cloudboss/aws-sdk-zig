/// Information about the installed EKS add-on (GuardDuty security agent).
pub const AddonDetails = struct {
    /// Status of the installed EKS add-on.
    addon_status: ?[]const u8,

    /// Version of the installed EKS add-on.
    addon_version: ?[]const u8,

    pub const json_field_names = .{
        .addon_status = "AddonStatus",
        .addon_version = "AddonVersion",
    };
};

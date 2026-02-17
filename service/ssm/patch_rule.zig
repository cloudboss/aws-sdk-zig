const PatchComplianceLevel = @import("patch_compliance_level.zig").PatchComplianceLevel;
const PatchFilterGroup = @import("patch_filter_group.zig").PatchFilterGroup;

/// Defines an approval rule for a patch baseline.
pub const PatchRule = struct {
    /// The number of days after the release date of each patch matched by the rule
    /// that the patch
    /// is marked as approved in the patch baseline. For example, a value of `7`
    /// means that
    /// patches are approved seven days after they are released.
    ///
    /// Patch Manager evaluates patch release dates using Coordinated Universal Time
    /// (UTC). If the
    /// day represented by `7` is `2025-11-16`, patches released between
    /// `2025-11-16T00:00:00Z` and `2025-11-16T23:59:59Z` will be included in the
    /// approval.
    ///
    /// This parameter is marked as `Required: No`, but your request must include a
    /// value
    /// for either `ApproveAfterDays` or `ApproveUntilDate`.
    ///
    /// Not supported for Debian Server or Ubuntu Server.
    ///
    /// Use caution when setting this value for Windows Server patch baselines.
    /// Because patch
    /// updates that are replaced by later updates are removed, setting too broad a
    /// value for this
    /// parameter can result in crucial patches not being installed. For more
    /// information, see the
    /// **Windows Server** tab in the topic [How security
    /// patches are
    /// selected](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-selecting-patches.html) in the *Amazon Web Services Systems Manager User Guide*.
    approve_after_days: ?i32,

    /// The cutoff date for auto approval of released patches. Any patches released
    /// on or before
    /// this date are installed automatically.
    ///
    /// Enter dates in the format `YYYY-MM-DD`. For example,
    /// `2025-11-16`.
    ///
    /// Patch Manager evaluates patch release dates using Coordinated Universal Time
    /// (UTC). If you
    /// enter the date `2025-11-16`, patches released between
    /// `2025-11-16T00:00:00Z` and `2025-11-16T23:59:59Z` will be included in the
    /// approval.
    ///
    /// This parameter is marked as `Required: No`, but your request must include a
    /// value
    /// for either `ApproveUntilDate` or `ApproveAfterDays`.
    ///
    /// Not supported for Debian Server or Ubuntu Server.
    ///
    /// Use caution when setting this value for Windows Server patch baselines.
    /// Because patch
    /// updates that are replaced by later updates are removed, setting too broad a
    /// value for this
    /// parameter can result in crucial patches not being installed. For more
    /// information, see the
    /// **Windows Server** tab in the topic [How security
    /// patches are
    /// selected](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-selecting-patches.html) in the *Amazon Web Services Systems Manager User Guide*.
    approve_until_date: ?[]const u8,

    /// A compliance severity level for all approved patches in a patch baseline.
    compliance_level: ?PatchComplianceLevel,

    /// For managed nodes identified by the approval rule filters, enables a patch
    /// baseline to apply
    /// non-security updates available in the specified repository. The default
    /// value is
    /// `false`. Applies to Linux managed nodes only.
    enable_non_security: ?bool,

    /// The patch filter group that defines the criteria for the rule.
    patch_filter_group: PatchFilterGroup,

    pub const json_field_names = .{
        .approve_after_days = "ApproveAfterDays",
        .approve_until_date = "ApproveUntilDate",
        .compliance_level = "ComplianceLevel",
        .enable_non_security = "EnableNonSecurity",
        .patch_filter_group = "PatchFilterGroup",
    };
};

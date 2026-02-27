const PatchRuleGroup = @import("patch_rule_group.zig").PatchRuleGroup;
const PatchComplianceLevel = @import("patch_compliance_level.zig").PatchComplianceLevel;
const PatchComplianceStatus = @import("patch_compliance_status.zig").PatchComplianceStatus;
const PatchFilterGroup = @import("patch_filter_group.zig").PatchFilterGroup;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const PatchAction = @import("patch_action.zig").PatchAction;
const PatchSource = @import("patch_source.zig").PatchSource;

/// Defines the basic information about a patch baseline override.
pub const BaselineOverride = struct {
    approval_rules: ?PatchRuleGroup,

    /// A list of explicitly approved patches for the baseline.
    ///
    /// For information about accepted formats for lists of approved patches and
    /// rejected patches,
    /// see [Package
    /// name formats for approved and rejected patch
    /// lists](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html) in the *Amazon Web Services Systems Manager User Guide*.
    approved_patches: ?[]const []const u8,

    /// Defines the compliance level for approved patches. When an approved patch is
    /// reported as
    /// missing, this value describes the severity of the compliance violation.
    approved_patches_compliance_level: ?PatchComplianceLevel,

    /// Indicates whether the list of approved patches includes non-security updates
    /// that should be
    /// applied to the managed nodes. The default value is `false`. Applies to Linux
    /// managed
    /// nodes only.
    approved_patches_enable_non_security: bool = false,

    /// Indicates whether managed nodes for which there are available
    /// security-related patches that
    /// have not been approved by the baseline are being defined as `COMPLIANT` or
    /// `NON_COMPLIANT`. This option is specified when the `CreatePatchBaseline`
    /// or `UpdatePatchBaseline` commands are run.
    ///
    /// Applies to Windows Server managed nodes only.
    available_security_updates_compliance_status: ?PatchComplianceStatus,

    global_filters: ?PatchFilterGroup,

    /// The operating system rule used by the patch baseline override.
    operating_system: ?OperatingSystem,

    /// A list of explicitly rejected patches for the baseline.
    ///
    /// For information about accepted formats for lists of approved patches and
    /// rejected patches,
    /// see [Package
    /// name formats for approved and rejected patch
    /// lists](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-approved-rejected-package-name-formats.html) in the *Amazon Web Services Systems Manager User Guide*.
    rejected_patches: ?[]const []const u8,

    /// The action for Patch Manager to take on patches included in the
    /// `RejectedPackages` list. A patch can be allowed only if it is a dependency
    /// of another
    /// package, or blocked entirely along with packages that include it as a
    /// dependency.
    rejected_patches_action: ?PatchAction,

    /// Information about the patches to use to update the managed nodes, including
    /// target operating
    /// systems and source repositories. Applies to Linux managed nodes only.
    sources: ?[]const PatchSource,

    pub const json_field_names = .{
        .approval_rules = "ApprovalRules",
        .approved_patches = "ApprovedPatches",
        .approved_patches_compliance_level = "ApprovedPatchesComplianceLevel",
        .approved_patches_enable_non_security = "ApprovedPatchesEnableNonSecurity",
        .available_security_updates_compliance_status = "AvailableSecurityUpdatesComplianceStatus",
        .global_filters = "GlobalFilters",
        .operating_system = "OperatingSystem",
        .rejected_patches = "RejectedPatches",
        .rejected_patches_action = "RejectedPatchesAction",
        .sources = "Sources",
    };
};

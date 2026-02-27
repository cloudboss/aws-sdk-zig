const PatchOperationType = @import("patch_operation_type.zig").PatchOperationType;
const RebootOption = @import("reboot_option.zig").RebootOption;

/// Defines the high-level patch compliance state for a managed node, providing
/// information
/// about the number of installed, missing, not applicable, and failed patches
/// along with metadata
/// about the operation when this information was gathered for the managed node.
pub const InstancePatchState = struct {
    /// The number of security-related patches that are available but not approved
    /// because they
    /// didn't meet the patch baseline requirements. For example, an updated version
    /// of a patch might
    /// have been released before the specified auto-approval period was over.
    ///
    /// Applies to Windows Server managed nodes only.
    available_security_update_count: ?i32,

    /// The ID of the patch baseline used to patch the managed node.
    baseline_id: []const u8,

    /// The number of patches per node that are specified as `Critical` for
    /// compliance
    /// reporting in the patch baseline aren't installed. These patches might be
    /// missing, have failed
    /// installation, were rejected, or were installed but awaiting a required
    /// managed node reboot. The
    /// status of these managed nodes is `NON_COMPLIANT`.
    critical_non_compliant_count: ?i32,

    /// The number of patches from the patch baseline that were attempted to be
    /// installed during the
    /// last patching operation, but failed to install.
    failed_count: i32 = 0,

    /// The number of patches from the patch baseline that are installed on the
    /// managed node.
    installed_count: i32 = 0,

    /// The number of patches not specified in the patch baseline that are installed
    /// on the managed
    /// node.
    installed_other_count: i32 = 0,

    /// The number of patches installed by Patch Manager since the last time the
    /// managed node was
    /// rebooted.
    installed_pending_reboot_count: ?i32,

    /// The number of patches installed on a managed node that are specified in a
    /// `RejectedPatches` list. Patches with a status of `InstalledRejected` were
    /// typically installed before they were added to a `RejectedPatches` list.
    ///
    /// If `ALLOW_AS_DEPENDENCY` is the specified option for
    /// `RejectedPatchesAction`, the value of `InstalledRejectedCount` will
    /// always be `0` (zero).
    installed_rejected_count: ?i32,

    /// An https URL or an Amazon Simple Storage Service (Amazon S3) path-style URL
    /// to a list of
    /// patches to be installed. This patch installation list, which you maintain in
    /// an S3 bucket in YAML
    /// format and specify in the SSM document `AWS-RunPatchBaseline`, overrides the
    /// patches
    /// specified by the default patch baseline.
    ///
    /// For more information about the `InstallOverrideList` parameter, see [SSM
    /// Command
    /// document for patching: `AWS-RunPatchBaseline`
    /// ](https://docs.aws.amazon.com/systems-manager/latest/userguide/patch-manager-about-aws-runpatchbaseline.html) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    install_override_list: ?[]const u8,

    /// The ID of the managed node the high-level patch compliance information was
    /// collected
    /// for.
    instance_id: []const u8,

    /// The time of the last attempt to patch the managed node with `NoReboot`
    /// specified
    /// as the reboot option.
    last_no_reboot_install_operation_time: ?i64,

    /// The number of patches from the patch baseline that are applicable for the
    /// managed node but
    /// aren't currently installed.
    missing_count: i32 = 0,

    /// The number of patches from the patch baseline that aren't applicable for the
    /// managed node
    /// and therefore aren't installed on the node. This number may be truncated if
    /// the list of patch
    /// names is very large. The number of patches beyond this limit are reported in
    /// `UnreportedNotApplicableCount`.
    not_applicable_count: i32 = 0,

    /// The type of patching operation that was performed: or
    ///
    /// * `SCAN` assesses the patch compliance state.
    ///
    /// * `INSTALL` installs missing patches.
    operation: PatchOperationType,

    /// The time the most recent patching operation completed on the managed node.
    operation_end_time: i64,

    /// The time the most recent patching operation was started on the managed node.
    operation_start_time: i64,

    /// The number of patches per node that are specified as other than `Critical`
    /// or
    /// `Security` but aren't compliant with the patch baseline. The status of these
    /// managed
    /// nodes is `NON_COMPLIANT`.
    other_non_compliant_count: ?i32,

    /// Placeholder information. This field will always be empty in the current
    /// release of the
    /// service.
    owner_information: ?[]const u8,

    /// The name of the patch group the managed node belongs to.
    patch_group: []const u8,

    /// Indicates the reboot option specified in the patch baseline.
    ///
    /// Reboot options apply to `Install` operations only. Reboots aren't attempted
    /// for
    /// Patch Manager `Scan` operations.
    ///
    /// * `RebootIfNeeded`: Patch Manager tries to reboot the managed node if it
    /// installed any patches, or if any patches are detected with a status of
    /// `InstalledPendingReboot`.
    ///
    /// * `NoReboot`: Patch Manager attempts to install missing packages without
    ///   trying
    /// to reboot the system. Patches installed with this option are assigned a
    /// status of
    /// `InstalledPendingReboot`. These patches might not be in effect until a
    /// reboot is
    /// performed.
    reboot_option: ?RebootOption,

    /// The number of patches per node that are specified as `Security` in a patch
    /// advisory aren't installed. These patches might be missing, have failed
    /// installation, were
    /// rejected, or were installed but awaiting a required managed node reboot. The
    /// status of these
    /// managed nodes is `NON_COMPLIANT`.
    security_non_compliant_count: ?i32,

    /// The ID of the patch baseline snapshot used during the patching operation
    /// when this
    /// compliance data was collected.
    snapshot_id: ?[]const u8,

    /// The number of patches beyond the supported limit of `NotApplicableCount`
    /// that
    /// aren't reported by name to Inventory. Inventory is a tool in Amazon Web
    /// Services Systems Manager.
    unreported_not_applicable_count: ?i32,

    pub const json_field_names = .{
        .available_security_update_count = "AvailableSecurityUpdateCount",
        .baseline_id = "BaselineId",
        .critical_non_compliant_count = "CriticalNonCompliantCount",
        .failed_count = "FailedCount",
        .installed_count = "InstalledCount",
        .installed_other_count = "InstalledOtherCount",
        .installed_pending_reboot_count = "InstalledPendingRebootCount",
        .installed_rejected_count = "InstalledRejectedCount",
        .install_override_list = "InstallOverrideList",
        .instance_id = "InstanceId",
        .last_no_reboot_install_operation_time = "LastNoRebootInstallOperationTime",
        .missing_count = "MissingCount",
        .not_applicable_count = "NotApplicableCount",
        .operation = "Operation",
        .operation_end_time = "OperationEndTime",
        .operation_start_time = "OperationStartTime",
        .other_non_compliant_count = "OtherNonCompliantCount",
        .owner_information = "OwnerInformation",
        .patch_group = "PatchGroup",
        .reboot_option = "RebootOption",
        .security_non_compliant_count = "SecurityNonCompliantCount",
        .snapshot_id = "SnapshotId",
        .unreported_not_applicable_count = "UnreportedNotApplicableCount",
    };
};

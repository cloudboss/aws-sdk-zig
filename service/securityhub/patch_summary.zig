/// Provides an overview of the patch compliance status for an instance against
/// a selected
/// compliance standard.
pub const PatchSummary = struct {
    /// The number of patches from the compliance standard that failed to install.
    ///
    /// The value can be an integer from `0` to `100000`.
    failed_count: ?i32 = null,

    /// The identifier of the compliance standard that was used to determine the
    /// patch
    /// compliance status.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256.
    id: []const u8,

    /// The number of patches from the compliance standard that were installed
    /// successfully.
    ///
    /// The value can be an integer from `0` to `100000`.
    installed_count: ?i32 = null,

    /// The number of installed patches that are not part of the compliance
    /// standard.
    ///
    /// The value can be an integer from `0` to `100000`.
    installed_other_count: ?i32 = null,

    /// The number of patches that were applied, but that require the instance to be
    /// rebooted in
    /// order to be marked as installed.
    ///
    /// The value can be an integer from `0` to `100000`.
    installed_pending_reboot: ?i32 = null,

    /// The number of patches that are installed but are also on a list of patches
    /// that the
    /// customer rejected.
    ///
    /// The value can be an integer from `0` to `100000`.
    installed_rejected_count: ?i32 = null,

    /// The number of patches that are part of the compliance standard but are not
    /// installed.
    /// The count includes patches that failed to install.
    ///
    /// The value can be an integer from `0` to `100000`.
    missing_count: ?i32 = null,

    /// The type of patch operation performed. For Patch Manager, the values are
    /// `SCAN` and `INSTALL`.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256.
    operation: ?[]const u8 = null,

    /// Indicates when the operation completed.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    operation_end_time: ?[]const u8 = null,

    /// Indicates when the operation started.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub CSPM, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    operation_start_time: ?[]const u8 = null,

    /// The reboot option specified for the instance.
    ///
    /// Length Constraints: Minimum length of 1. Maximum length of 256.
    reboot_option: ?[]const u8 = null,

    pub const json_field_names = .{
        .failed_count = "FailedCount",
        .id = "Id",
        .installed_count = "InstalledCount",
        .installed_other_count = "InstalledOtherCount",
        .installed_pending_reboot = "InstalledPendingReboot",
        .installed_rejected_count = "InstalledRejectedCount",
        .missing_count = "MissingCount",
        .operation = "Operation",
        .operation_end_time = "OperationEndTime",
        .operation_start_time = "OperationStartTime",
        .reboot_option = "RebootOption",
    };
};

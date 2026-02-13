const PatchComplianceDataState = @import("patch_compliance_data_state.zig").PatchComplianceDataState;

/// Information about the state of a patch on a particular managed node as it
/// relates to the
/// patch baseline used to patch the node.
pub const PatchComplianceData = struct {
    /// The classification of the patch, such as `SecurityUpdates`, `Updates`,
    /// and `CriticalUpdates`.
    classification: []const u8,

    /// The IDs of one or more Common Vulnerabilities and Exposure (CVE) issues that
    /// are resolved by
    /// the patch.
    ///
    /// **Note:**
    ///
    /// Currently, CVE ID values are reported only for patches with a status of
    /// `Missing` or `Failed`.
    cve_ids: ?[]const u8,

    /// The date/time the patch was installed on the managed node. Not all operating
    /// systems provide
    /// this level of information.
    installed_time: i64,

    /// The operating system-specific ID of the patch.
    kb_id: []const u8,

    /// The severity of the patch such as `Critical`, `Important`, and
    /// `Moderate`.
    severity: []const u8,

    /// The state of the patch on the managed node, such as INSTALLED or FAILED.
    ///
    /// For descriptions of each patch state, see [About
    /// patch
    /// compliance](https://docs.aws.amazon.com/systems-manager/latest/userguide/compliance-about.html#compliance-monitor-patch) in the *Amazon Web Services Systems Manager User Guide*.
    state: PatchComplianceDataState,

    /// The title of the patch.
    title: []const u8,

    pub const json_field_names = .{
        .classification = "Classification",
        .cve_ids = "CVEIds",
        .installed_time = "InstalledTime",
        .kb_id = "KBId",
        .severity = "Severity",
        .state = "State",
        .title = "Title",
    };
};

const CheckResult = @import("check_result.zig").CheckResult;
const CheckType = @import("check_type.zig").CheckType;

/// A check on the environment to identify environment health and validate
/// VMware VCF licensing compliance.
pub const Check = struct {
    /// A unique ID for the check.
    id: ?[]const u8 = null,

    /// The time when environment health began to be impaired.
    impaired_since: ?i64 = null,

    /// The check result.
    result: ?CheckResult = null,

    /// The check type. Amazon EVS performs the following checks:
    ///
    /// * `KEY_REUSE`: Verifies that the VCF license key is not used by another
    ///   Amazon EVS environment.
    /// * `KEY_COVERAGE`: Verifies that the VCF license key allocates sufficient
    ///   vCPU cores for all deployed hosts.
    /// * `REACHABILITY`: Verifies that the Amazon EVS control plane has a
    ///   persistent connection to SDDC Manager.
    /// * `HOST_COUNT`: Verifies that the environment meets the minimum host count.
    /// * `VCENTER_REACHABILITY`: Verifies vCenter Server reachability through the
    ///   vCenter connector.
    /// * `VCENTER_VM_SYNC`: Verifies that the vCenter connector can synchronize VM
    ///   inventory from vCenter Server.
    /// * `VCENTER_VM_EVENT`: Verifies that the vCenter connector can receive VM
    ///   lifecycle events from vCenter Server.
    /// * `OPERATIONS_MANAGER_REACHABILITY`: Verifies Operations Manager
    ///   reachability through the Operations Manager connector.
    /// * `SDDC_MANAGER_REACHABILITY`: Verifies SDDC Manager reachability through
    ///   the SDDC Manager connector.
    /// * `SDDC_MANAGER_HOST_COUNT`: Verifies that the host count reported by SDDC
    ///   Manager meets Amazon EVS minimum requirements.
    /// * `SDDC_MANAGER_KEY_COVERAGE`: Verifies that the VCF license key configured
    ///   in SDDC Manager covers all deployed hosts.
    /// * `SDDC_MANAGER_KEY_REUSE`: Verifies that the VCF license key configured in
    ///   SDDC Manager is not used by another Amazon EVS environment.
    /// * `CONNECTOR_HEALTH`: Aggregate health across all connectors in the
    ///   environment.
    @"type": ?CheckType = null,

    pub const json_field_names = .{
        .id = "id",
        .impaired_since = "impairedSince",
        .result = "result",
        .@"type" = "type",
    };
};

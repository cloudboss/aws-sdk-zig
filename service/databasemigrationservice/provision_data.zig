/// Information about provisioning resources for an DMS serverless replication.
pub const ProvisionData = struct {
    /// The timestamp when provisioning became available.
    date_new_provisioning_data_available: ?i64 = null,

    /// The timestamp when DMS provisioned replication resources.
    date_provisioned: ?i64 = null,

    /// Whether the new provisioning is available to the replication.
    is_new_provisioning_available: bool = false,

    /// The number of capacity units the replication is using.
    provisioned_capacity_units: i32 = 0,

    /// The current provisioning state
    provision_state: ?[]const u8 = null,

    /// A message describing the reason that DMS provisioned new resources for the
    /// serverless
    /// replication.
    reason_for_new_provisioning_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .date_new_provisioning_data_available = "DateNewProvisioningDataAvailable",
        .date_provisioned = "DateProvisioned",
        .is_new_provisioning_available = "IsNewProvisioningAvailable",
        .provisioned_capacity_units = "ProvisionedCapacityUnits",
        .provision_state = "ProvisionState",
        .reason_for_new_provisioning_data = "ReasonForNewProvisioningData",
    };
};

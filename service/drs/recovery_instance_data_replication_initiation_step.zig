const RecoveryInstanceDataReplicationInitiationStepName = @import("recovery_instance_data_replication_initiation_step_name.zig").RecoveryInstanceDataReplicationInitiationStepName;
const RecoveryInstanceDataReplicationInitiationStepStatus = @import("recovery_instance_data_replication_initiation_step_status.zig").RecoveryInstanceDataReplicationInitiationStepStatus;

/// Data replication initiation step.
pub const RecoveryInstanceDataReplicationInitiationStep = struct {
    /// The name of the step.
    name: ?RecoveryInstanceDataReplicationInitiationStepName,

    /// The status of the step.
    status: ?RecoveryInstanceDataReplicationInitiationStepStatus,

    pub const json_field_names = .{
        .name = "name",
        .status = "status",
    };
};

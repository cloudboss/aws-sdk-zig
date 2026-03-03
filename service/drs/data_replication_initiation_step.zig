const DataReplicationInitiationStepName = @import("data_replication_initiation_step_name.zig").DataReplicationInitiationStepName;
const DataReplicationInitiationStepStatus = @import("data_replication_initiation_step_status.zig").DataReplicationInitiationStepStatus;

/// Data replication initiation step.
pub const DataReplicationInitiationStep = struct {
    /// The name of the step.
    name: ?DataReplicationInitiationStepName = null,

    /// The status of the step.
    status: ?DataReplicationInitiationStepStatus = null,

    pub const json_field_names = .{
        .name = "name",
        .status = "status",
    };
};

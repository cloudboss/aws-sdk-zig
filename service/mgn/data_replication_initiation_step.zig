const DataReplicationInitiationStepName = @import("data_replication_initiation_step_name.zig").DataReplicationInitiationStepName;
const DataReplicationInitiationStepStatus = @import("data_replication_initiation_step_status.zig").DataReplicationInitiationStepStatus;

/// Data replication initiation step.
pub const DataReplicationInitiationStep = struct {
    /// Request to query data initiation step name.
    name: ?DataReplicationInitiationStepName = null,

    /// Request to query data initiation status.
    status: ?DataReplicationInitiationStepStatus = null,

    pub const json_field_names = .{
        .name = "name",
        .status = "status",
    };
};

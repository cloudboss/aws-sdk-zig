const RecoveryInstanceDataReplicationInitiationStep = @import("recovery_instance_data_replication_initiation_step.zig").RecoveryInstanceDataReplicationInitiationStep;

/// Data replication initiation.
pub const RecoveryInstanceDataReplicationInitiation = struct {
    /// The date and time of the current attempt to initiate data replication.
    start_date_time: ?[]const u8,

    /// The steps of the current attempt to initiate data replication.
    steps: ?[]const RecoveryInstanceDataReplicationInitiationStep,

    pub const json_field_names = .{
        .start_date_time = "startDateTime",
        .steps = "steps",
    };
};

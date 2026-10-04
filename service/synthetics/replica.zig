const CanaryState = @import("canary_state.zig").CanaryState;
const ReplicationStatus = @import("replication_status.zig").ReplicationStatus;
const VpcConfigOutput = @import("vpc_config_output.zig").VpcConfigOutput;

/// A structure that contains information about a canary replica in a specific
/// location.
pub const Replica = struct {
    /// The current state of the canary in this replica location.
    canary_state: ?CanaryState = null,

    /// The date and time that the replica was last modified.
    last_modified: ?i64 = null,

    /// The Amazon Web Services Region where this replica is located.
    location: ?[]const u8 = null,

    /// A structure that contains information about the replication status of this
    /// replica.
    replication_status: ?ReplicationStatus = null,

    /// The VPC configuration for the canary replica in this location.
    vpc_config: ?VpcConfigOutput = null,

    pub const json_field_names = .{
        .canary_state = "CanaryState",
        .last_modified = "LastModified",
        .location = "Location",
        .replication_status = "ReplicationStatus",
        .vpc_config = "VpcConfig",
    };
};

const ReplicaRoleType = @import("replica_role_type.zig").ReplicaRoleType;
const ReplicaStatusType = @import("replica_status_type.zig").ReplicaStatusType;

/// Contains information about a replica user pool, including Region, status,
/// role, and ARN.
pub const UserPoolReplicaType = struct {
    /// The Amazon Web Services Region where the replica is located.
    region_name: ?[]const u8 = null,

    /// The role of the user pool replica that determines which API operations are
    /// enabled.
    ///
    /// **PRIMARY**
    ///
    /// The primary replica supports all end user and administrator operations.
    ///
    /// **SECONDARY**
    ///
    /// The secondary replica supports a limited set of end user and administrator
    /// operations.
    /// Generally, only administrator operations that set configurations specific to
    /// the replica, and
    /// only end-user operations that do not create or change attributes of a user
    /// are supported.
    role: ?ReplicaRoleType = null,

    /// The current status of the replica.
    ///
    /// **CREATING**
    ///
    /// The replica is being created.
    ///
    /// **INACTIVE**
    ///
    /// The replica has been created, but is not accepting requests for end-users.
    /// Administrator configuration operations are supported.
    ///
    /// **ACTIVE**
    ///
    /// The replica is available for both end-user and administrator operations.
    ///
    /// **DELETING**
    ///
    /// The replica is being deleted.
    status: ?ReplicaStatusType = null,

    /// The Amazon Resource Name (ARN) of the replica user pool.
    user_pool_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .region_name = "RegionName",
        .role = "Role",
        .status = "Status",
        .user_pool_arn = "UserPoolArn",
    };
};

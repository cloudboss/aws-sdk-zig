/// Information about the status of a read replica.
pub const AwsRdsDbStatusInfo = struct {
    /// If the read replica is currently in an error state, provides the error
    /// details.
    message: ?[]const u8 = null,

    /// Whether the read replica instance is operating normally.
    normal: ?bool = null,

    /// The status of the read replica instance.
    status: ?[]const u8 = null,

    /// The type of status. For a read replica, the status type is read replication.
    status_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .normal = "Normal",
        .status = "Status",
        .status_type = "StatusType",
    };
};

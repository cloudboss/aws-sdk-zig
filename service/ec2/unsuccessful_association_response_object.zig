/// Describes an unsuccessful application status check association.
pub const UnsuccessfulAssociationResponseObject = struct {
    /// The ID of the application status check.
    application_status_check_id: ?[]const u8 = null,

    /// The type of association. Valid values: `EC2TAG` and `INSTANCE_ID`.
    association_type: ?[]const u8 = null,

    /// The association value. For `EC2TAG`, the value is formatted as `key=value`.
    /// For `INSTANCE_ID`, the value is the instance ID.
    association_value: ?[]const u8 = null,

    /// The reason the association failed.
    reason: ?[]const u8 = null,
};

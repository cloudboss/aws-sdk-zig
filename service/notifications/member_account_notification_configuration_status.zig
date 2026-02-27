pub const MemberAccountNotificationConfigurationStatus = enum {
    /// The member account Notification Configuration status is ACTIVE.
    active,
    /// The member account Notification Configuration status is PENDING.
    pending,
    /// The member account Notification Configuration status is INACTIVE.
    inactive,
    /// The member account Notification Configuration status is CREATING.
    creating,
    /// The member account Notification Configuration status is DELETING.
    deleting,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending = "PENDING",
        .inactive = "INACTIVE",
        .creating = "CREATING",
        .deleting = "DELETING",
    };
};

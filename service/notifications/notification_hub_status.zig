pub const NotificationHubStatus = enum {
    /// Incoming Notification Events are being replicated to this Notification Hub.
    /// A Notification Hub with this status can be deregistered.
    active,
    /// Notification Hub is initializing. Cannot deregister a Notification Hub in
    /// this status.
    registering,
    /// Notification Hub is being deleted. Cannot register a Notification Hub in the
    /// same region as one in this status.
    deregistering,
    /// Notification Hub is in a failure state. Incoming Notification Events are not
    /// being replicated to this Hub.
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .registering = "REGISTERING",
        .deregistering = "DEREGISTERING",
        .inactive = "INACTIVE",
    };
};

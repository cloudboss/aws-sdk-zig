const GroupLifecycleEventsDesiredStatus = @import("group_lifecycle_events_desired_status.zig").GroupLifecycleEventsDesiredStatus;
const GroupLifecycleEventsStatus = @import("group_lifecycle_events_status.zig").GroupLifecycleEventsStatus;

/// The Resource Groups settings for this Amazon Web Services account.
pub const AccountSettings = struct {
    /// The desired target status of the group lifecycle events feature. If
    group_lifecycle_events_desired_status: ?GroupLifecycleEventsDesiredStatus = null,

    /// The current status of the group lifecycle events feature.
    group_lifecycle_events_status: ?GroupLifecycleEventsStatus = null,

    /// The text of any error message occurs during an attempt to turn group
    /// lifecycle events on or off.
    group_lifecycle_events_status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_lifecycle_events_desired_status = "GroupLifecycleEventsDesiredStatus",
        .group_lifecycle_events_status = "GroupLifecycleEventsStatus",
        .group_lifecycle_events_status_message = "GroupLifecycleEventsStatusMessage",
    };
};

/// An object that contains information about the inbox placement data settings
/// for a
/// verified domain that’s associated with your Amazon Web Services account.
/// This data is available only
/// if you enabled the Deliverability dashboard for the domain.
pub const InboxPlacementTrackingOption = struct {
    /// Specifies whether inbox placement data is being tracked for the domain.
    global: bool = false,

    /// An array of strings, one for each major email provider that the inbox
    /// placement data
    /// applies to.
    tracked_isps: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .global = "Global",
        .tracked_isps = "TrackedIsps",
    };
};

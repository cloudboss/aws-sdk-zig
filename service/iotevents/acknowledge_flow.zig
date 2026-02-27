/// Specifies whether to get notified for alarm state changes.
pub const AcknowledgeFlow = struct {
    /// The value must be `TRUE` or `FALSE`. If `TRUE`, you
    /// receive a notification when the alarm state changes. You must choose to
    /// acknowledge the
    /// notification before the alarm state can return to `NORMAL`. If `FALSE`,
    /// you won't receive notifications. The alarm automatically changes to the
    /// `NORMAL`
    /// state when the input property value returns to the specified range.
    enabled: bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};

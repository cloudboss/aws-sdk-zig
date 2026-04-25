/// Specifies which alarms an alarm mute rule applies to.
///
/// You can target up to 100 specific alarms by name. When a mute rule is
/// active, the targeted alarms continue to evaluate metrics and transition
/// between states, but their configured actions are muted.
pub const MuteTargets = struct {
    /// The list of alarm names that this mute rule targets. You can specify up to
    /// 100 alarm names.
    ///
    /// Each alarm name must be between 1 and 255 characters in length. The alarm
    /// names must match existing alarms in your Amazon Web Services account and
    /// region.
    alarm_names: []const []const u8,

    pub const json_field_names = .{
        .alarm_names = "AlarmNames",
    };
};

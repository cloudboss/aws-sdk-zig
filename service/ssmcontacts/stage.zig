const Target = @import("target.zig").Target;

/// A set amount of time that an escalation plan or engagement plan engages the
/// specified
/// contacts or contact methods.
pub const Stage = struct {
    /// The time to wait until beginning the next stage. The duration can only be
    /// set to 0 if a
    /// target is specified.
    duration_in_minutes: i32,

    /// The contacts or contact methods that the escalation plan or engagement plan
    /// is
    /// engaging.
    targets: []const Target,

    pub const json_field_names = .{
        .duration_in_minutes = "DurationInMinutes",
        .targets = "Targets",
    };
};

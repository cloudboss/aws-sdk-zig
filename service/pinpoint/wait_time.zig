/// Specifies a duration or a date and time that indicates when Amazon Pinpoint
/// determines whether an activity's conditions have been met or an activity
/// moves participants to the next activity in a journey.
pub const WaitTime = struct {
    /// The amount of time to wait, as a duration in ISO 8601 format, before
    /// determining whether the activity's conditions have been met or moving
    /// participants to the next activity in the journey.
    wait_for: ?[]const u8,

    /// The date and time, in ISO 8601 format, when Amazon Pinpoint determines
    /// whether the activity's conditions have been met or the activity moves
    /// participants to the next activity in the journey.
    wait_until: ?[]const u8,

    pub const json_field_names = .{
        .wait_for = "WaitFor",
        .wait_until = "WaitUntil",
    };
};

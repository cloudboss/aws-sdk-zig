/// Priority class configuration. When included in `PriorityClasses`, these
/// class configurations define how tasks are queued.
pub const PriorityClass = struct {
    /// Name of the priority class.
    name: []const u8,

    /// Weight of the priority class. The value is within a range from 0 to 100,
    /// where 0 is the default.
    ///
    /// A weight of 0 is the lowest priority and 100 is the highest. Weight 0 is the
    /// default.
    weight: i32,

    pub const json_field_names = .{
        .name = "Name",
        .weight = "Weight",
    };
};

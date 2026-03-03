/// A mapping between one or more workgroups and a capacity reservation.
pub const CapacityAssignment = struct {
    /// The list of workgroup names for the capacity assignment.
    work_group_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .work_group_names = "WorkGroupNames",
    };
};

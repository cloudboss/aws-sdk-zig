/// Defines the valid range of work unit IDs for querying the execution service.
pub const WorkUnitRange = struct {
    /// Defines the maximum work unit ID in the range. The maximum value is
    /// inclusive.
    work_unit_id_max: i64 = 0,

    /// Defines the minimum work unit ID in the range.
    work_unit_id_min: i64 = 0,

    /// A work token used to query the execution service.
    work_unit_token: []const u8,

    pub const json_field_names = .{
        .work_unit_id_max = "WorkUnitIdMax",
        .work_unit_id_min = "WorkUnitIdMin",
        .work_unit_token = "WorkUnitToken",
    };
};

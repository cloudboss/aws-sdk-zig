/// Summary information about a constraint.
pub const ConstraintSummary = struct {
    /// The description of the constraint.
    description: ?[]const u8,

    /// The type of constraint.
    ///
    /// * `LAUNCH`
    ///
    /// * `NOTIFICATION`
    ///
    /// * STACKSET
    ///
    /// * `TEMPLATE`
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .@"type" = "Type",
    };
};

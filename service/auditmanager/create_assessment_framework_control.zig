/// The control entity attributes that uniquely identify an existing control to
/// be added to
/// a framework in Audit Manager.
pub const CreateAssessmentFrameworkControl = struct {
    /// The unique identifier of the control.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

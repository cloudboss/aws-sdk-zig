const CreateAssessmentFrameworkControl = @import("create_assessment_framework_control.zig").CreateAssessmentFrameworkControl;

/// A `controlSet` entity that represents a collection of controls in Audit
/// Manager. This doesn't contain the control set ID.
pub const UpdateAssessmentFrameworkControlSet = struct {
    /// The list of controls that are contained within the control set.
    controls: []const CreateAssessmentFrameworkControl,

    /// The unique identifier for the control set.
    id: ?[]const u8,

    /// The name of the control set.
    name: []const u8,

    pub const json_field_names = .{
        .controls = "controls",
        .id = "id",
        .name = "name",
    };
};

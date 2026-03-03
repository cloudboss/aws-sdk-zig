const CreateAssessmentFrameworkControl = @import("create_assessment_framework_control.zig").CreateAssessmentFrameworkControl;

/// A `controlSet` entity that represents a collection of controls in Audit
/// Manager. This doesn't contain the control set ID.
pub const CreateAssessmentFrameworkControlSet = struct {
    /// The list of controls within the control set. This doesn't contain the
    /// control set ID.
    controls: ?[]const CreateAssessmentFrameworkControl = null,

    /// The name of the control set.
    name: []const u8,

    pub const json_field_names = .{
        .controls = "controls",
        .name = "name",
    };
};

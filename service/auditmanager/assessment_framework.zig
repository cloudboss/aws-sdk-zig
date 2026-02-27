const AssessmentControlSet = @import("assessment_control_set.zig").AssessmentControlSet;
const FrameworkMetadata = @import("framework_metadata.zig").FrameworkMetadata;

/// The file used to structure and automate Audit Manager assessments for a
/// given
/// compliance standard.
pub const AssessmentFramework = struct {
    /// The Amazon Resource Name (ARN) of the framework.
    arn: ?[]const u8,

    /// The control sets that are associated with the framework.
    control_sets: ?[]const AssessmentControlSet,

    /// The unique identifier for the framework.
    id: ?[]const u8,

    metadata: ?FrameworkMetadata,

    pub const json_field_names = .{
        .arn = "arn",
        .control_sets = "controlSets",
        .id = "id",
        .metadata = "metadata",
    };
};

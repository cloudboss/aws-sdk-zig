/// Information about the resources that would be included in the actual runbook
/// execution, if
/// it were to be run.
pub const TargetPreview = struct {
    /// The number of resources of a certain type included in an execution preview.
    count: ?i32,

    /// A type of resource that was included in the execution preview.
    target_type: ?[]const u8,

    pub const json_field_names = .{
        .count = "Count",
        .target_type = "TargetType",
    };
};

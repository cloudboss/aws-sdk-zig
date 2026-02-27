/// Specifies a filter used for the target resource input in an experiment
/// template.
///
/// For more information, see [Resource
/// filters](https://docs.aws.amazon.com/fis/latest/userguide/targets.html#target-filters)
/// in the *Fault Injection Service User Guide*.
pub const ExperimentTemplateTargetInputFilter = struct {
    /// The attribute path for the filter.
    path: []const u8,

    /// The attribute values for the filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .path = "path",
        .values = "values",
    };
};

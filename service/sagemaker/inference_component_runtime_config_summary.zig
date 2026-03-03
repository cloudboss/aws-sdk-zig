/// Details about the runtime settings for the model that is deployed with the
/// inference component.
pub const InferenceComponentRuntimeConfigSummary = struct {
    /// The number of runtime copies of the model container that are currently
    /// deployed.
    current_copy_count: ?i32 = null,

    /// The number of runtime copies of the model container that you requested to
    /// deploy with the inference component.
    desired_copy_count: ?i32 = null,

    pub const json_field_names = .{
        .current_copy_count = "CurrentCopyCount",
        .desired_copy_count = "DesiredCopyCount",
    };
};

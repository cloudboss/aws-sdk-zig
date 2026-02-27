/// A summary of the progress of the template generation.
pub const TemplateProgress = struct {
    /// The number of resources that failed the template generation.
    resources_failed: ?i32,

    /// The number of resources that are still pending the template generation.
    resources_pending: ?i32,

    /// The number of resources that are in-process for the template generation.
    resources_processing: ?i32,

    /// The number of resources that succeeded the template generation.
    resources_succeeded: ?i32,
};

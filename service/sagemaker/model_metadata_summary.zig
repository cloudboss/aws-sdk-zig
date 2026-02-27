/// A summary of the model metadata.
pub const ModelMetadataSummary = struct {
    /// The machine learning domain of the model.
    domain: []const u8,

    /// The machine learning framework of the model.
    framework: []const u8,

    /// The framework version of the model.
    framework_version: []const u8,

    /// The name of the model.
    model: []const u8,

    /// The machine learning task of the model.
    task: []const u8,

    pub const json_field_names = .{
        .domain = "Domain",
        .framework = "Framework",
        .framework_version = "FrameworkVersion",
        .model = "Model",
        .task = "Task",
    };
};

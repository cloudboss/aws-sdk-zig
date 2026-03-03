/// Any dependencies related to hub content, such as scripts, model artifacts,
/// datasets, or notebooks.
pub const HubContentDependency = struct {
    /// The hub content dependency copy path.
    dependency_copy_path: ?[]const u8 = null,

    /// The hub content dependency origin path.
    dependency_origin_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .dependency_copy_path = "DependencyCopyPath",
        .dependency_origin_path = "DependencyOriginPath",
    };
};

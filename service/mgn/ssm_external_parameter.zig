/// AWS Systems Manager Document external parameter.
pub const SsmExternalParameter = union(enum) {
    /// AWS Systems Manager Document external parameters dynamic path.
    dynamic_path: ?[]const u8,

    pub const json_field_names = .{
        .dynamic_path = "dynamicPath",
    };
};

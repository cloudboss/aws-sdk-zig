/// The workload specification for benchmark tool configuration. Provide an
/// inline YAML or JSON string.
pub const WorkloadSpec = union(enum) {
    /// An inline YAML or JSON string that defines benchmark parameters.
    @"inline": ?[]const u8,

    pub const json_field_names = .{
        .@"inline" = "Inline",
    };
};

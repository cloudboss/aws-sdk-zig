const SourceAlgorithm = @import("source_algorithm.zig").SourceAlgorithm;

/// A list of algorithms that were used to create a model package.
pub const SourceAlgorithmSpecification = struct {
    /// A list of the algorithms that were used to create a model package.
    source_algorithms: []const SourceAlgorithm,

    pub const json_field_names = .{
        .source_algorithms = "SourceAlgorithms",
    };
};

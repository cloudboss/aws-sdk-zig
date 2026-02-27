const HashAlgorithm = @import("hash_algorithm.zig").HashAlgorithm;

/// The hash algorithms that are available to a code-signing job.
pub const HashAlgorithmOptions = struct {
    /// The set of accepted hash algorithms allowed in a code-signing job.
    allowed_values: []const HashAlgorithm,

    /// The default hash algorithm that is used in a code-signing job.
    default_value: HashAlgorithm,

    pub const json_field_names = .{
        .allowed_values = "allowedValues",
        .default_value = "defaultValue",
    };
};

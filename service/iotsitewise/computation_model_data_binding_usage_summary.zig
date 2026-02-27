const MatchedDataBinding = @import("matched_data_binding.zig").MatchedDataBinding;

/// A summary of how a specific data binding is used across computation models.
/// This tracks
/// dependencies between data sources and computation models, allowing you to
/// understand the
/// impact of changes to data sources.
pub const ComputationModelDataBindingUsageSummary = struct {
    /// The list of computation model IDs that use this data binding. This allows
    /// identification
    /// of all computation models affected by changes to the referenced data source.
    computation_model_ids: []const []const u8,

    /// The data binding matched by the filter criteria. Contains details about
    /// specific data
    /// binding values used by the computation models.
    matched_data_binding: MatchedDataBinding,

    pub const json_field_names = .{
        .computation_model_ids = "computationModelIds",
        .matched_data_binding = "matchedDataBinding",
    };
};

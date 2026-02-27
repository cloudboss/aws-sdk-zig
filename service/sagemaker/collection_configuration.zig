const aws = @import("aws");

/// Configuration information for the Amazon SageMaker Debugger output tensor
/// collections.
pub const CollectionConfiguration = struct {
    /// The name of the tensor collection. The name must be unique relative to other
    /// rule configuration names.
    collection_name: ?[]const u8,

    /// Parameter values for the tensor collection. The allowed parameters are
    /// `"name"`, `"include_regex"`, `"reduction_config"`, `"save_config"`,
    /// `"tensor_names"`, and `"save_histogram"`.
    collection_parameters: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .collection_parameters = "CollectionParameters",
    };
};

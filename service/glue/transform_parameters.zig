const FindMatchesParameters = @import("find_matches_parameters.zig").FindMatchesParameters;
const TransformType = @import("transform_type.zig").TransformType;

/// The algorithm-specific parameters that are associated with the machine
/// learning
/// transform.
pub const TransformParameters = struct {
    /// The parameters for the find matches algorithm.
    find_matches_parameters: ?FindMatchesParameters,

    /// The type of machine learning transform.
    ///
    /// For information about the types of machine learning transforms, see
    /// [Creating Machine Learning
    /// Transforms](https://docs.aws.amazon.com/glue/latest/dg/add-job-machine-learning-transform.html).
    transform_type: TransformType,

    pub const json_field_names = .{
        .find_matches_parameters = "FindMatchesParameters",
        .transform_type = "TransformType",
    };
};

const StepType = @import("step_type.zig").StepType;
const TransformationFunction = @import("transformation_function.zig").TransformationFunction;

/// A custom processing step for documents moving through a data source
/// ingestion pipeline. To process documents after they have been converted into
/// chunks, set the step to apply to `POST_CHUNKING`.
pub const Transformation = struct {
    /// When the service applies the transformation.
    step_to_apply: StepType,

    /// A Lambda function that processes documents.
    transformation_function: TransformationFunction,

    pub const json_field_names = .{
        .step_to_apply = "stepToApply",
        .transformation_function = "transformationFunction",
    };
};

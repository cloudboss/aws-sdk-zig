const JoinSource = @import("join_source.zig").JoinSource;

/// The data structure used to specify the data to be used for inference in a
/// batch transform job and to associate the data that is relevant to the
/// prediction results in the output. The input filter provided allows you to
/// exclude input data that is not needed for inference in a batch transform
/// job. The output filter provided allows you to include input data relevant to
/// interpreting the predictions in the output from the job. For more
/// information, see [Associate Prediction Results with their Corresponding
/// Input
/// Records](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform-data-processing.html).
pub const DataProcessing = struct {
    /// A
    /// [JSONPath](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform-data-processing.html#data-processing-operators) expression used to select a portion of the input data to pass to the algorithm. Use the `InputFilter` parameter to exclude fields, such as an ID column, from the input. If you want SageMaker to pass the entire input dataset to the algorithm, accept the default value `$`.
    ///
    /// Examples: `"$"`, `"$[1:]"`, `"$.features"`
    input_filter: ?[]const u8,

    /// Specifies the source of the data to join with the transformed data. The
    /// valid values are `None` and `Input`. The default value is `None`, which
    /// specifies not to join the input with the transformed data. If you want the
    /// batch transform job to join the original input data with the transformed
    /// data, set `JoinSource` to `Input`. You can specify `OutputFilter` as an
    /// additional filter to select a portion of the joined dataset and store it in
    /// the output file.
    ///
    /// For JSON or JSONLines objects, such as a JSON array, SageMaker adds the
    /// transformed data to the input JSON object in an attribute called
    /// `SageMakerOutput`. The joined result for JSON must be a key-value pair
    /// object. If the input is not a key-value pair object, SageMaker creates a new
    /// JSON file. In the new JSON file, and the input data is stored under the
    /// `SageMakerInput` key and the results are stored in `SageMakerOutput`.
    ///
    /// For CSV data, SageMaker takes each row as a JSON array and joins the
    /// transformed data with the input by appending each transformed row to the end
    /// of the input. The joined data has the original input data followed by the
    /// transformed data and the output is a CSV file.
    ///
    /// For information on how joining in applied, see [Workflow for Associating
    /// Inferences with Input
    /// Records](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform-data-processing.html#batch-transform-data-processing-workflow).
    join_source: ?JoinSource,

    /// A
    /// [JSONPath](https://docs.aws.amazon.com/sagemaker/latest/dg/batch-transform-data-processing.html#data-processing-operators) expression used to select a portion of the joined dataset to save in the output file for a batch transform job. If you want SageMaker to store the entire input dataset in the output file, leave the default value, `$`. If you specify indexes that aren't within the dimension size of the joined dataset, you get an error.
    ///
    /// Examples: `"$"`, `"$[0,5:]"`, `"$['id','SageMakerOutput']"`
    output_filter: ?[]const u8,

    pub const json_field_names = .{
        .input_filter = "InputFilter",
        .join_source = "JoinSource",
        .output_filter = "OutputFilter",
    };
};

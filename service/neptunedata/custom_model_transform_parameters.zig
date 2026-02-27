/// Contains custom model transform parameters. See [Use a trained model to
/// generate new model
/// artifacts](https://docs.aws.amazon.com/neptune/latest/userguide/machine-learning-model-transform.html).
pub const CustomModelTransformParameters = struct {
    /// The path to the Amazon S3 location where the Python module implementing your
    /// model is located. This must point to a valid existing Amazon S3 location
    /// that contains, at a minimum, a training script, a transform script, and a
    /// `model-hpo-configuration.json` file.
    source_s3_directory_path: []const u8,

    /// The name of the entry point in your module of a script that should be run
    /// after the best model from the hyperparameter search has been identified, to
    /// compute the model artifacts necessary for model deployment. It should be
    /// able to run with no command-line arguments. The default is `transform.py`.
    transform_entry_point_script: ?[]const u8,

    pub const json_field_names = .{
        .source_s3_directory_path = "sourceS3DirectoryPath",
        .transform_entry_point_script = "transformEntryPointScript",
    };
};

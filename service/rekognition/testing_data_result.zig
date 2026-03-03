const TestingData = @import("testing_data.zig").TestingData;
const ValidationData = @import("validation_data.zig").ValidationData;

/// Sagemaker Groundtruth format manifest files for the input, output and
/// validation
/// datasets that are used and created during testing.
pub const TestingDataResult = struct {
    /// The testing dataset that was supplied for training.
    input: ?TestingData = null,

    /// The subset of the dataset that was actually tested. Some images (assets)
    /// might not be tested due to
    /// file formatting and other issues.
    output: ?TestingData = null,

    /// The location of the data validation manifest. The data validation manifest
    /// is created for the test dataset during model training.
    validation: ?ValidationData = null,

    pub const json_field_names = .{
        .input = "Input",
        .output = "Output",
        .validation = "Validation",
    };
};

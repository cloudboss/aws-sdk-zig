/// This structure specifies how to split the data into train and validation
/// datasets.
///
/// The validation and training datasets must contain the same headers. For jobs
/// created by calling `CreateAutoMLJob`, the validation dataset must be less
/// than 2 GB in size.
pub const AutoMLDataSplitConfig = struct {
    /// The validation fraction (optional) is a float that specifies the portion of
    /// the training dataset to be used for validation. The default value is 0.2,
    /// and values must be greater than 0 and less than 1. We recommend setting this
    /// value to be less than 0.5.
    validation_fraction: ?f32 = null,

    pub const json_field_names = .{
        .validation_fraction = "ValidationFraction",
    };
};

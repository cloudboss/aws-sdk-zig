const aws = @import("aws");

/// The training data configuration to use when creating a domain recommender or
/// custom solution version (trained model).
pub const TrainingDataConfig = struct {
    /// Specifies the columns to exclude from training. Each key is a dataset type,
    /// and each value is a list of columns.
    /// Exclude columns to control what data Amazon Personalize uses to generate
    /// recommendations.
    ///
    /// For example, you might have a column that you want to use only to filter
    /// recommendations. You can
    /// exclude this column from training and Amazon Personalize considers it only
    /// when filtering.
    excluded_dataset_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// A map that specifies which columns to include from each dataset during
    /// training. The map can contain up to 3 entries, where each key is a dataset
    /// name (maximum length of 256 characters, must contain only letters and
    /// underscores) and each value is an array of up to 50 column names. Column
    /// names can be up to 150 characters long, must start with a letter or
    /// underscore, and can contain only letters, numbers, and underscores.
    included_dataset_columns: ?[]const aws.map.MapEntry([]const []const u8) = null,

    pub const json_field_names = .{
        .excluded_dataset_columns = "excludedDatasetColumns",
        .included_dataset_columns = "includedDatasetColumns",
    };
};

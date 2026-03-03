const ColumnStatisticsConfiguration = @import("column_statistics_configuration.zig").ColumnStatisticsConfiguration;
const StatisticsConfiguration = @import("statistics_configuration.zig").StatisticsConfiguration;
const EntityDetectorConfiguration = @import("entity_detector_configuration.zig").EntityDetectorConfiguration;
const ColumnSelector = @import("column_selector.zig").ColumnSelector;

/// Configuration for profile jobs. Configuration can be used to select columns,
/// do evaluations, and override default
/// parameters of evaluations. When configuration is undefined, the profile job
/// will apply default settings to all
/// supported columns.
pub const ProfileConfiguration = struct {
    /// List of configurations for column evaluations.
    /// ColumnStatisticsConfigurations are used to
    /// select evaluations and override parameters of evaluations for particular
    /// columns. When
    /// ColumnStatisticsConfigurations is undefined, the profile job will profile
    /// all supported columns
    /// and run all supported evaluations.
    column_statistics_configurations: ?[]const ColumnStatisticsConfiguration = null,

    /// Configuration for inter-column evaluations. Configuration can be used to
    /// select evaluations and override
    /// parameters of evaluations. When configuration is undefined, the profile job
    /// will run all supported
    /// inter-column evaluations.
    dataset_statistics_configuration: ?StatisticsConfiguration = null,

    /// Configuration of entity detection for a profile job. When undefined, entity
    /// detection is disabled.
    entity_detector_configuration: ?EntityDetectorConfiguration = null,

    /// List of column selectors. ProfileColumns can be used to select columns from
    /// the dataset. When
    /// ProfileColumns is undefined, the profile job will profile all supported
    /// columns.
    profile_columns: ?[]const ColumnSelector = null,

    pub const json_field_names = .{
        .column_statistics_configurations = "ColumnStatisticsConfigurations",
        .dataset_statistics_configuration = "DatasetStatisticsConfiguration",
        .entity_detector_configuration = "EntityDetectorConfiguration",
        .profile_columns = "ProfileColumns",
    };
};

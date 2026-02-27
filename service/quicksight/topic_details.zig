const TopicConfigOptions = @import("topic_config_options.zig").TopicConfigOptions;
const DatasetMetadata = @import("dataset_metadata.zig").DatasetMetadata;
const TopicUserExperienceVersion = @import("topic_user_experience_version.zig").TopicUserExperienceVersion;

/// A structure that describes the details of a topic, such as its name,
/// description, and associated data sets.
pub const TopicDetails = struct {
    /// Configuration options for a `Topic`.
    config_options: ?TopicConfigOptions,

    /// The data sets that the topic is associated with.
    data_sets: ?[]const DatasetMetadata,

    /// The description of the topic.
    description: ?[]const u8,

    /// The name of the topic.
    name: ?[]const u8,

    /// The user experience version of a topic.
    user_experience_version: ?TopicUserExperienceVersion,

    pub const json_field_names = .{
        .config_options = "ConfigOptions",
        .data_sets = "DataSets",
        .description = "Description",
        .name = "Name",
        .user_experience_version = "UserExperienceVersion",
    };
};

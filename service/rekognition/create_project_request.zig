const aws = @import("aws");

const ProjectAutoUpdate = @import("project_auto_update.zig").ProjectAutoUpdate;
const CustomizationFeature = @import("customization_feature.zig").CustomizationFeature;

pub const CreateProjectRequest = struct {
    /// Specifies whether automatic retraining should be attempted for the versions
    /// of the
    /// project. Automatic retraining is done as a best effort. Required argument
    /// for Content
    /// Moderation. Applicable only to adapters.
    auto_update: ?ProjectAutoUpdate = null,

    /// Specifies feature that is being customized. If no value is provided
    /// CUSTOM_LABELS is used as a default.
    feature: ?CustomizationFeature = null,

    /// The name of the project to create.
    project_name: []const u8,

    /// A set of tags (key-value pairs) that you want to attach to the project.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .auto_update = "AutoUpdate",
        .feature = "Feature",
        .project_name = "ProjectName",
        .tags = "Tags",
    };
};

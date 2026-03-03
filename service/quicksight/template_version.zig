const DataSetConfiguration = @import("data_set_configuration.zig").DataSetConfiguration;
const TemplateError = @import("template_error.zig").TemplateError;
const Sheet = @import("sheet.zig").Sheet;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// A version of a template.
pub const TemplateVersion = struct {
    /// The time that this template version was created.
    created_time: ?i64 = null,

    /// Schema of the dataset identified by the placeholder. Any dashboard created
    /// from this
    /// template should be bound to new datasets matching the same schema described
    /// through this
    /// API operation.
    data_set_configurations: ?[]const DataSetConfiguration = null,

    /// The description of the template.
    description: ?[]const u8 = null,

    /// Errors associated with this template version.
    errors: ?[]const TemplateError = null,

    /// A list of the associated sheets with the unique identifier and name of each
    /// sheet.
    sheets: ?[]const Sheet = null,

    /// The Amazon Resource Name (ARN) of an analysis or template that was used to
    /// create this
    /// template.
    source_entity_arn: ?[]const u8 = null,

    /// The status that is associated with the template.
    ///
    /// * `CREATION_IN_PROGRESS`
    ///
    /// * `CREATION_SUCCESSFUL`
    ///
    /// * `CREATION_FAILED`
    ///
    /// * `UPDATE_IN_PROGRESS`
    ///
    /// * `UPDATE_SUCCESSFUL`
    ///
    /// * `UPDATE_FAILED`
    ///
    /// * `DELETED`
    status: ?ResourceStatus = null,

    /// The ARN of the theme associated with this version of the template.
    theme_arn: ?[]const u8 = null,

    /// The version number of the template version.
    version_number: ?i64 = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .data_set_configurations = "DataSetConfigurations",
        .description = "Description",
        .errors = "Errors",
        .sheets = "Sheets",
        .source_entity_arn = "SourceEntityArn",
        .status = "Status",
        .theme_arn = "ThemeArn",
        .version_number = "VersionNumber",
    };
};

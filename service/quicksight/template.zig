const TemplateVersion = @import("template_version.zig").TemplateVersion;

/// A template object. A *template* is an entity in Quick Sight that
/// encapsulates the metadata required to create an analysis and that you can
/// use to create
/// a dashboard. A template adds a layer of abstraction by using placeholders to
/// replace the
/// dataset associated with an analysis. You can use templates to create
/// dashboards by
/// replacing dataset placeholders with datasets that follow the same schema
/// that was used
/// to create the source analysis and template.
///
/// You can share templates across Amazon Web Services accounts by allowing
/// users in other Amazon Web Services accounts to
/// create a template or a dashboard from an existing template.
pub const Template = struct {
    /// The Amazon Resource Name (ARN) of the template.
    arn: ?[]const u8,

    /// Time when this was created.
    created_time: ?i64,

    /// Time when this was last updated.
    last_updated_time: ?i64,

    /// The display name of the template.
    name: ?[]const u8,

    /// The ID for the template. This is unique per Amazon Web Services Region for
    /// each Amazon Web Services account.
    template_id: ?[]const u8,

    /// A structure describing the versions of the template.
    version: ?TemplateVersion,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .last_updated_time = "LastUpdatedTime",
        .name = "Name",
        .template_id = "TemplateId",
        .version = "Version",
    };
};

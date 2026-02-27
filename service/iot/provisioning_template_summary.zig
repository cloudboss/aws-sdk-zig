const TemplateType = @import("template_type.zig").TemplateType;

/// A summary of information about a provisioning template.
pub const ProvisioningTemplateSummary = struct {
    /// The date when the provisioning template summary was created.
    creation_date: ?i64,

    /// The description of the provisioning template.
    description: ?[]const u8,

    /// True if the fleet provision template is enabled, otherwise false.
    enabled: ?bool,

    /// The date when the provisioning template summary was last modified.
    last_modified_date: ?i64,

    /// The ARN of the provisioning template.
    template_arn: ?[]const u8,

    /// The name of the provisioning template.
    template_name: ?[]const u8,

    /// The type you define in a provisioning template. You can create a template
    /// with only one type.
    /// You can't change the template type after its creation. The default value is
    /// `FLEET_PROVISIONING`.
    /// For more information about provisioning template, see: [Provisioning
    /// template](https://docs.aws.amazon.com/iot/latest/developerguide/provision-template.html).
    type: ?TemplateType,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .description = "description",
        .enabled = "enabled",
        .last_modified_date = "lastModifiedDate",
        .template_arn = "templateArn",
        .template_name = "templateName",
        .type = "type",
    };
};

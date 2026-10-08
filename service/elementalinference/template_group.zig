/// A named set of graphics-compositing templates used by the crop feature,
/// specified in the templateGroups array of a CroppingConfig.
pub const TemplateGroup = struct {
    /// A name for the template group.
    name: []const u8,

    /// An array of Amazon S3 URIs that point to the graphics-compositing templates
    /// for this group. You can specify 1 or 2 URIs. Each URI must be in the form
    /// `s3://bucket-name/key`. Elemental Inference reads these templates using the
    /// IAM role that you specify in accessRoleArn.
    template_uris: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .template_uris = "templateUris",
    };
};

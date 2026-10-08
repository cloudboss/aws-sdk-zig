const TemplateGroup = @import("template_group.zig").TemplateGroup;

/// A type of OutputConfig, used when the output in a feed is for the crop
/// feature.
pub const CroppingConfig = struct {
    /// An array of template groups for the crop output. Each template group
    /// provides the graphics-compositing templates that Elemental Inference applies
    /// to the cropped video. You can specify from 1 to 4 template groups.
    template_groups: ?[]const TemplateGroup = null,

    pub const json_field_names = .{
        .template_groups = "templateGroups",
    };
};

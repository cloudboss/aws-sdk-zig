const ChoiceContent = @import("choice_content.zig").ChoiceContent;
const AdditionalResourceType = @import("additional_resource_type.zig").AdditionalResourceType;

/// The choice level additional resources for a custom lens.
///
/// This field does not apply to Amazon Web Services official lenses.
pub const AdditionalResources = struct {
    /// The URLs for additional resources, either helpful resources or improvement
    /// plans, for a custom lens. Up to five additional URLs can be specified.
    content: ?[]const ChoiceContent,

    /// Type of additional resource for a custom lens.
    type: ?AdditionalResourceType,

    pub const json_field_names = .{
        .content = "Content",
        .type = "Type",
    };
};

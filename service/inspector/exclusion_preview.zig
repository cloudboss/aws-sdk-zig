const Attribute = @import("attribute.zig").Attribute;
const Scope = @import("scope.zig").Scope;

/// Contains information about what is excluded from an assessment run given the
/// current
/// state of the assessment template.
pub const ExclusionPreview = struct {
    /// The system-defined attributes for the exclusion preview.
    attributes: ?[]const Attribute,

    /// The description of the exclusion preview.
    description: []const u8,

    /// The recommendation for the exclusion preview.
    recommendation: []const u8,

    /// The AWS resources for which the exclusion preview pertains.
    scopes: []const Scope,

    /// The name of the exclusion preview.
    title: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .description = "description",
        .recommendation = "recommendation",
        .scopes = "scopes",
        .title = "title",
    };
};

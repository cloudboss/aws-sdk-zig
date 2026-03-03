const ReplacementTemplate = @import("replacement_template.zig").ReplacementTemplate;

/// The `ReplaceEmailContent` object to be used for a specific
/// `BulkEmailEntry`. The `ReplacementTemplate` can be specified
/// within this object.
pub const ReplacementEmailContent = struct {
    /// The `ReplacementTemplate` associated with
    /// `ReplacementEmailContent`.
    replacement_template: ?ReplacementTemplate = null,

    pub const json_field_names = .{
        .replacement_template = "ReplacementTemplate",
    };
};

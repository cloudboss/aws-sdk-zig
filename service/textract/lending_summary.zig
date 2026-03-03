const DocumentGroup = @import("document_group.zig").DocumentGroup;

/// Contains information regarding DocumentGroups and UndetectedDocumentTypes.
pub const LendingSummary = struct {
    /// Contains an array of all DocumentGroup objects.
    document_groups: ?[]const DocumentGroup = null,

    /// UndetectedDocumentTypes.
    undetected_document_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .document_groups = "DocumentGroups",
        .undetected_document_types = "UndetectedDocumentTypes",
    };
};

const MetaFlowCategory = @import("meta_flow_category.zig").MetaFlowCategory;

/// Contains summary information about a WhatsApp Flow, including its ID, name,
/// status, and categories.
pub const MetaFlowSummary = struct {
    /// The categories that classify the business purpose of the Flow.
    flow_categories: []const MetaFlowCategory,

    /// The unique identifier of the Flow assigned by Meta.
    flow_id: []const u8,

    /// The name of the Flow.
    flow_name: []const u8,

    /// The lifecycle status of the Flow (DRAFT, PUBLISHED, DEPRECATED, BLOCKED, or
    /// THROTTLED).
    flow_status: []const u8,

    /// A list of validation errors from Meta, if any.
    validation_errors: []const []const u8,

    pub const json_field_names = .{
        .flow_categories = "flowCategories",
        .flow_id = "flowId",
        .flow_name = "flowName",
        .flow_status = "flowStatus",
        .validation_errors = "validationErrors",
    };
};

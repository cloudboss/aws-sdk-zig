const MessageTemplateFilterOperator = @import("message_template_filter_operator.zig").MessageTemplateFilterOperator;

/// The message template fields to filter the message template query results by.
/// The following is the list of supported field names:
///
/// * name
/// * description
/// * channel
/// * channelSubtype
/// * language
/// * qualifier
/// * createdTime
/// * lastModifiedTime
/// * lastModifiedBy
/// * groupingConfiguration.criteria
/// * groupingConfiguration.values
pub const MessageTemplateFilterField = struct {
    /// Whether to treat null value as a match for the attribute field.
    include_no_existence: ?bool,

    /// The name of the attribute field to filter the message templates by.
    name: []const u8,

    /// The operator to use for filtering.
    operator: MessageTemplateFilterOperator,

    /// The values of attribute field to filter the message template by.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .include_no_existence = "includeNoExistence",
        .name = "name",
        .operator = "operator",
        .values = "values",
    };
};

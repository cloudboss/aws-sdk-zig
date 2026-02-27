const AlertCategory = @import("alert_category.zig").AlertCategory;

/// Alert configuration parameters.
pub const Alert = struct {
    /// The code for the alert. For example, `NOT_PROCESSED`.
    alert_code: []const u8,

    /// If an alert is generated for a resource, an explanation of the reason for
    /// the alert.
    alert_message: []const u8,

    /// The category that MediaTailor assigns to the alert.
    category: ?AlertCategory,

    /// The timestamp when the alert was last modified.
    last_modified_time: i64,

    /// The Amazon Resource Names (ARNs) related to this alert.
    related_resource_arns: []const []const u8,

    /// The Amazon Resource Name (ARN) of the resource.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .alert_code = "AlertCode",
        .alert_message = "AlertMessage",
        .category = "Category",
        .last_modified_time = "LastModifiedTime",
        .related_resource_arns = "RelatedResourceArns",
        .resource_arn = "ResourceArn",
    };
};

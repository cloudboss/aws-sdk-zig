/// Contains summary information about an account access manager application.
pub const ApplicationSummary = struct {
    /// The ARN of the application.
    application_arn: []const u8,

    /// The date and time when the application was created.
    created_at: i64,

    /// The tenant identifier associated with the application.
    tenant_id: ?[]const u8 = null,

    /// The date and time when the application was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .created_at = "createdAt",
        .tenant_id = "tenantId",
        .updated_at = "updatedAt",
    };
};

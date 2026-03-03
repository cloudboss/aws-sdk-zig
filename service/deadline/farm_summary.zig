/// The summary of details for a farm.
pub const FarmSummary = struct {
    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The display name of the farm.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The farm ID.
    farm_id: []const u8,

    /// The ARN for the KMS key.
    kms_key_arn: ?[]const u8 = null,

    /// The date and time the resource was updated.
    updated_at: ?i64 = null,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .created_by = "createdBy",
        .display_name = "displayName",
        .farm_id = "farmId",
        .kms_key_arn = "kmsKeyArn",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

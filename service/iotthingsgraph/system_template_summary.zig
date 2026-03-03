/// An object that contains information about a system.
pub const SystemTemplateSummary = struct {
    /// The ARN of the system.
    arn: ?[]const u8 = null,

    /// The date when the system was created.
    created_at: ?i64 = null,

    /// The ID of the system.
    id: ?[]const u8 = null,

    /// The revision number of the system.
    revision_number: ?i64 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .revision_number = "revisionNumber",
    };
};

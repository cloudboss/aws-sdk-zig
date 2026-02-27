/// An object that contains information about a system.
pub const SystemTemplateSummary = struct {
    /// The ARN of the system.
    arn: ?[]const u8,

    /// The date when the system was created.
    created_at: ?i64,

    /// The ID of the system.
    id: ?[]const u8,

    /// The revision number of the system.
    revision_number: ?i64,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .revision_number = "revisionNumber",
    };
};

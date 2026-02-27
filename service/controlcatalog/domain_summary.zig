/// A summary of metadata for a domain.
pub const DomainSummary = struct {
    /// The Amazon Resource Name (ARN) that identifies the domain.
    arn: []const u8,

    /// The time when the domain was created.
    create_time: i64,

    /// The description of the domain.
    description: []const u8,

    /// The time when the domain was most recently updated.
    last_update_time: i64,

    /// The name of the domain.
    name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .create_time = "CreateTime",
        .description = "Description",
        .last_update_time = "LastUpdateTime",
        .name = "Name",
    };
};

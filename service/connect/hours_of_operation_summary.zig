/// Contains summary information about hours of operation for a contact center.
pub const HoursOfOperationSummary = struct {
    /// The Amazon Resource Name (ARN) of the hours of operation.
    arn: ?[]const u8,

    /// The identifier of the hours of operation.
    id: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the hours of operation.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

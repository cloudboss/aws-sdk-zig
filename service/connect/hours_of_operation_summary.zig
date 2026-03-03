/// Contains summary information about hours of operation for a contact center.
pub const HoursOfOperationSummary = struct {
    /// The Amazon Resource Name (ARN) of the hours of operation.
    arn: ?[]const u8 = null,

    /// The identifier of the hours of operation.
    id: ?[]const u8 = null,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the hours of operation.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

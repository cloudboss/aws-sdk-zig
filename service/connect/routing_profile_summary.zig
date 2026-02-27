/// Contains summary information about a routing profile.
pub const RoutingProfileSummary = struct {
    /// The Amazon Resource Name (ARN) of the routing profile.
    arn: ?[]const u8,

    /// The identifier of the routing profile.
    id: ?[]const u8,

    /// The Amazon Web Services Region where this resource was last modified.
    last_modified_region: ?[]const u8,

    /// The timestamp when this resource was last modified.
    last_modified_time: ?i64,

    /// The name of the routing profile.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
    };
};

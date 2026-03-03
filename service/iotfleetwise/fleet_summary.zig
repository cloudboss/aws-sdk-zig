/// Information about a fleet.
///
/// You can use the API operation to return this
/// information about multiple fleets.
pub const FleetSummary = struct {
    /// The Amazon Resource Name (ARN) of the fleet.
    arn: []const u8,

    /// The time the fleet was created, in seconds since epoch (January 1, 1970 at
    /// midnight
    /// UTC time).
    creation_time: i64,

    /// A brief description of the fleet.
    description: ?[]const u8 = null,

    /// The unique ID of the fleet.
    id: []const u8,

    /// The time the fleet was last updated in seconds since epoch (January 1, 1970
    /// at
    /// midnight UTC time).
    last_modification_time: ?i64 = null,

    /// The ARN of the signal catalog associated with the fleet.
    signal_catalog_arn: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_modification_time = "lastModificationTime",
        .signal_catalog_arn = "signalCatalogArn",
    };
};

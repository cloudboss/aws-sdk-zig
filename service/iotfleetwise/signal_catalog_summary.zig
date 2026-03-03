/// Information about a collection of standardized signals, which can be
/// attributes,
/// branches, sensors, or actuators.
pub const SignalCatalogSummary = struct {
    /// The Amazon Resource Name (ARN) of the signal catalog.
    arn: ?[]const u8 = null,

    /// The time the signal catalog was created in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    creation_time: ?i64 = null,

    /// The time the signal catalog was last updated in seconds since epoch (January
    /// 1, 1970 at midnight UTC time).
    last_modification_time: ?i64 = null,

    /// The name of the signal catalog.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .last_modification_time = "lastModificationTime",
        .name = "name",
    };
};

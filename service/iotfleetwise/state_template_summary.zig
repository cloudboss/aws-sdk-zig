/// Information about a state template.
///
/// Access to certain Amazon Web Services IoT FleetWise features is currently
/// gated. For more information, see [Amazon Web Services Region and feature
/// availability](https://docs.aws.amazon.com/iot-fleetwise/latest/developerguide/fleetwise-regions.html) in the *Amazon Web Services IoT FleetWise Developer Guide*.
pub const StateTemplateSummary = struct {
    /// The Amazon Resource Name (ARN) of the state template.
    arn: ?[]const u8,

    /// The time the state template was created, in seconds since epoch (January 1,
    /// 1970 at midnight UTC time).
    creation_time: ?i64,

    /// A brief description of the state template.
    description: ?[]const u8,

    /// The unique ID of the state template.
    id: ?[]const u8,

    /// The time the state template was last updated, in seconds since epoch
    /// (January 1, 1970 at midnight UTC time).
    last_modification_time: ?i64,

    /// The name of the state template.
    name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the signal catalog associated with the
    /// state template.
    signal_catalog_arn: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .last_modification_time = "lastModificationTime",
        .name = "name",
        .signal_catalog_arn = "signalCatalogArn",
    };
};

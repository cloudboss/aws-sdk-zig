/// The detector.
pub const Detector = struct {
    /// The detector ARN.
    arn: ?[]const u8 = null,

    /// Timestamp of when the detector was created.
    created_time: ?[]const u8 = null,

    /// The detector description.
    description: ?[]const u8 = null,

    /// The detector ID.
    detector_id: ?[]const u8 = null,

    /// The name of the event type.
    event_type_name: ?[]const u8 = null,

    /// Timestamp of when the detector was last updated.
    last_updated_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .detector_id = "detectorId",
        .event_type_name = "eventTypeName",
        .last_updated_time = "lastUpdatedTime",
    };
};

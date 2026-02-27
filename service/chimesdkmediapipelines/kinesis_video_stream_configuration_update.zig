/// The updated Kinesis video stream configuration object.
pub const KinesisVideoStreamConfigurationUpdate = struct {
    /// The updated time that data is retained.
    data_retention_in_hours: ?i32,

    pub const json_field_names = .{
        .data_retention_in_hours = "DataRetentionInHours",
    };
};

/// The detailed description of the event. Included in the information returned
/// by the
/// [DescribeEventDetails](https://docs.aws.amazon.com/health/latest/APIReference/API_DescribeEventDetails.html) operation.
pub const EventDescription = struct {
    /// The most recent description of the event.
    latest_description: ?[]const u8,

    pub const json_field_names = .{
        .latest_description = "latestDescription",
    };
};

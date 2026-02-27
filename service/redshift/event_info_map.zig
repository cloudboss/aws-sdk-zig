/// Describes event information.
pub const EventInfoMap = struct {
    /// The category of an Amazon Redshift event.
    event_categories: ?[]const []const u8,

    /// The description of an Amazon Redshift event.
    event_description: ?[]const u8,

    /// The identifier of an Amazon Redshift event.
    event_id: ?[]const u8,

    /// The severity of the event.
    ///
    /// Values: ERROR, INFO
    severity: ?[]const u8,
};

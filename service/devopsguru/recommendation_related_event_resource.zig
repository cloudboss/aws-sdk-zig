/// Information about an Amazon Web Services resource that emitted and event
/// that is related to a
/// recommendation in an insight.
pub const RecommendationRelatedEventResource = struct {
    /// The name of the resource that emitted the event. This corresponds to the
    /// `Name` field in an `EventResource` object.
    name: ?[]const u8,

    /// The type of the resource that emitted the event. This corresponds to the
    /// `Type` field in an `EventResource` object.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};

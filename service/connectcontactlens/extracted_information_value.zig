const PointOfInterest = @import("point_of_interest.zig").PointOfInterest;

/// An individual value extracted from the conversation, including its content
/// and the
/// locations where it was found.
pub const ExtractedInformationValue = struct {
    /// The text content of the extracted value.
    content: []const u8,

    /// The sections in the conversation that indicate where the extracted value was
    /// found.
    points_of_interest: []const PointOfInterest,

    pub const json_field_names = .{
        .content = "Content",
        .points_of_interest = "PointsOfInterest",
    };
};

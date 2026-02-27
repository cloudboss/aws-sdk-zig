const PointOfInterest = @import("point_of_interest.zig").PointOfInterest;

/// Provides information about the category rule that was matched.
pub const CategoryDetails = struct {
    /// The section of audio where the category rule was detected.
    points_of_interest: []const PointOfInterest,

    pub const json_field_names = .{
        .points_of_interest = "PointsOfInterest",
    };
};

const RandomSplitEntry = @import("random_split_entry.zig").RandomSplitEntry;

/// Specifies the settings for a random split activity in a journey. This type
/// of activity randomly sends specified percentages of participants down one of
/// as many as five paths in a journey, based on conditions that you specify.
pub const RandomSplitActivity = struct {
    /// The paths for the activity, including the percentage of participants to
    /// enter each path and the activity to perform for each path.
    branches: ?[]const RandomSplitEntry = null,

    pub const json_field_names = .{
        .branches = "Branches",
    };
};

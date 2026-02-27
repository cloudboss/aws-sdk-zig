/// Represents an activity type.
pub const ActivityType = struct {
    /// The name of this activity.
    ///
    /// The combination of activity type name and version must be unique within a
    /// domain.
    name: []const u8,

    /// The version of this activity.
    ///
    /// The combination of activity type name and version must be unique with in a
    /// domain.
    version: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .version = "version",
    };
};

/// Information about a build that could not be successfully deleted.
pub const BuildNotDeleted = struct {
    /// The ID of the build that could not be successfully deleted.
    id: ?[]const u8 = null,

    /// Additional information about the build that could not be successfully
    /// deleted.
    status_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .status_code = "statusCode",
    };
};

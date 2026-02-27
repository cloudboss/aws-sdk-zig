const ResourceStatus = @import("resource_status.zig").ResourceStatus;

/// The theme version.
pub const ThemeVersionSummary = struct {
    /// The Amazon Resource Name (ARN) of the theme version.
    arn: ?[]const u8,

    /// The date and time that this theme version was created.
    created_time: ?i64,

    /// The description of the theme version.
    description: ?[]const u8,

    /// The status of the theme version.
    status: ?ResourceStatus,

    /// The version number of the theme version.
    version_number: ?i64,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_time = "CreatedTime",
        .description = "Description",
        .status = "Status",
        .version_number = "VersionNumber",
    };
};

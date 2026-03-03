/// Describes whether a WorkSpace image needs to be updated with the latest
/// drivers and
/// other components required by Amazon WorkSpaces.
///
/// Only Windows 10 WorkSpace images can be programmatically updated at this
/// time.
pub const UpdateResult = struct {
    /// A description of whether updates for the WorkSpace image are pending or
    /// available.
    description: ?[]const u8 = null,

    /// Indicates whether updated drivers or other components are available for the
    /// specified
    /// WorkSpace image.
    update_available: ?bool = null,

    pub const json_field_names = .{
        .description = "Description",
        .update_available = "UpdateAvailable",
    };
};

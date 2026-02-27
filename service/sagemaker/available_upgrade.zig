/// Contains information about an available upgrade for a SageMaker Partner AI
/// App, including the version number and release notes.
pub const AvailableUpgrade = struct {
    /// A list of release notes describing the changes and improvements included in
    /// the available upgrade version.
    release_notes: ?[]const []const u8,

    /// The semantic version number of the available upgrade for the SageMaker
    /// Partner AI App.
    version: ?[]const u8,

    pub const json_field_names = .{
        .release_notes = "ReleaseNotes",
        .version = "Version",
    };
};

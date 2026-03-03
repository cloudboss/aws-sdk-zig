/// Details about a beta appliance software update.
pub const AlternateSoftwareMetadata = struct {
    /// The appliance software version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .version = "Version",
    };
};

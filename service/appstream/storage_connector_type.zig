/// The type of storage connector.
pub const StorageConnectorType = enum {
    homefolders,
    google_drive,
    one_drive,

    pub const json_field_names = .{
        .homefolders = "HOMEFOLDERS",
        .google_drive = "GOOGLE_DRIVE",
        .one_drive = "ONE_DRIVE",
    };
};

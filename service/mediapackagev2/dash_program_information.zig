/// Details about the content that you want MediaPackage to pass through in the
/// manifest to the playback device.
pub const DashProgramInformation = struct {
    /// A copyright statement about the content.
    copyright: ?[]const u8 = null,

    /// The language code for this manifest.
    language_code: ?[]const u8 = null,

    /// An absolute URL that contains more information about this content.
    more_information_url: ?[]const u8 = null,

    /// Information about the content provider.
    source: ?[]const u8 = null,

    /// The title for the manifest.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .copyright = "Copyright",
        .language_code = "LanguageCode",
        .more_information_url = "MoreInformationUrl",
        .source = "Source",
        .title = "Title",
    };
};

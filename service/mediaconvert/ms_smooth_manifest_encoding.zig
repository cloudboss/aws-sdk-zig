/// Use Manifest encoding to specify the encoding format for the server and
/// client manifest. Valid options are utf8 and utf16.
pub const MsSmoothManifestEncoding = enum {
    utf8,
    utf16,

    pub const json_field_names = .{
        .utf8 = "UTF8",
        .utf16 = "UTF16",
    };
};

const aws = @import("aws");

const CodeSigning = @import("code_signing.zig").CodeSigning;
const FileLocation = @import("file_location.zig").FileLocation;

/// Describes a file to be associated with an OTA update.
pub const OTAUpdateFile = struct {
    /// A list of name-attribute pairs. They won't be sent to devices as a part of
    /// the Job document.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The code signing method of the file.
    code_signing: ?CodeSigning = null,

    /// The location of the updated firmware.
    file_location: ?FileLocation = null,

    /// The name of the file.
    file_name: ?[]const u8 = null,

    /// An integer value you can include in the job document to allow your devices
    /// to identify the type of file received
    /// from the cloud.
    file_type: ?i32 = null,

    /// The file version.
    file_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .attributes = "attributes",
        .code_signing = "codeSigning",
        .file_location = "fileLocation",
        .file_name = "fileName",
        .file_type = "fileType",
        .file_version = "fileVersion",
    };
};

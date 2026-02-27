/// Specify the event message box (eMSG) version for ID3 timed metadata in your
/// output.
/// For more information, see ISO/IEC 23009-1:2022 section 5.10.3.3.3 Syntax.
/// Leave blank to use the default value Version 0.
/// When you specify Version 1, you must also set ID3 metadata to Passthrough.
pub const MpdTimedMetadataBoxVersion = enum {
    version_0,
    version_1,

    pub const json_field_names = .{
        .version_0 = "VERSION_0",
        .version_1 = "VERSION_1",
    };
};

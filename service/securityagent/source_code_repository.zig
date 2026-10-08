/// Represents a source code repository used for security analysis during a
/// pentest.
pub const SourceCodeRepository = struct {
    /// The Amazon S3 location of the source code repository archive.
    s_3_location: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_location = "s3Location",
    };
};

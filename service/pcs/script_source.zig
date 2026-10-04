/// The source location and integrity information for a node lifecycle script.
pub const ScriptSource = struct {
    /// The SHA-256 checksum of the script content, as a 64-character hexadecimal
    /// string. This value is optional. When specified, PCS uses this value to
    /// verify the integrity of the downloaded script.
    checksum: ?[]const u8 = null,

    /// The Amazon S3 version ID of the script. Use this value to pin the script to
    /// a specific version in a versioned Amazon S3 bucket. This value is only valid
    /// when `scriptLocation` is an Amazon S3 URI.
    s_3_version_id: ?[]const u8 = null,

    /// The location of the script. Specify either an Amazon S3 URI in the format
    /// `s3://bucket-name/key` or an HTTPS URL.
    script_location: []const u8,

    pub const json_field_names = .{
        .checksum = "checksum",
        .s_3_version_id = "s3VersionId",
        .script_location = "scriptLocation",
    };
};

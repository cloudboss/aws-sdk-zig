const S3Location = @import("s3_location.zig").S3Location;

/// Represents a file to stream.
pub const StreamFile = struct {
    /// The file ID.
    file_id: ?i32,

    /// The location of the file in S3.
    s_3_location: ?S3Location,

    pub const json_field_names = .{
        .file_id = "fileId",
        .s_3_location = "s3Location",
    };
};

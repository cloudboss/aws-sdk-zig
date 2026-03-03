const ReadSetPartSource = @import("read_set_part_source.zig").ReadSetPartSource;

/// The metadata of a single part of a file that was added to a multipart
/// upload. A list of these parts is returned in the response to the
/// ListReadSetUploadParts API.
pub const ReadSetUploadPartListItem = struct {
    /// A unique identifier used to confirm that parts are being added to the
    /// correct upload.
    checksum: []const u8,

    /// The time stamp for when a direct upload was created.
    creation_time: ?i64 = null,

    /// The time stamp for the most recent update to an uploaded part.
    last_updated_time: ?i64 = null,

    /// The number identifying the part in an upload.
    part_number: i32,

    /// The size of the the part in an upload.
    part_size: i64,

    /// The origin of the part being direct uploaded.
    part_source: ReadSetPartSource,

    pub const json_field_names = .{
        .checksum = "checksum",
        .creation_time = "creationTime",
        .last_updated_time = "lastUpdatedTime",
        .part_number = "partNumber",
        .part_size = "partSize",
        .part_source = "partSource",
    };
};

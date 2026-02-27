const ReadSetPartSource = @import("read_set_part_source.zig").ReadSetPartSource;

/// Part of the response to the CompleteReadSetUpload API, including metadata.
pub const CompleteReadSetUploadPartListItem = struct {
    /// A unique identifier used to confirm that parts are being added to the
    /// correct upload.
    checksum: []const u8,

    /// A number identifying the part in a read set upload.
    part_number: i32,

    /// The source file of the part being uploaded.
    part_source: ReadSetPartSource,

    pub const json_field_names = .{
        .checksum = "checksum",
        .part_number = "partNumber",
        .part_source = "partSource",
    };
};

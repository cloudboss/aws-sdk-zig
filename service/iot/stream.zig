/// Describes a group of files that can be streamed.
pub const Stream = struct {
    /// The ID of a file associated with a stream.
    file_id: ?i32,

    /// The stream ID.
    stream_id: ?[]const u8,

    pub const json_field_names = .{
        .file_id = "fileId",
        .stream_id = "streamId",
    };
};

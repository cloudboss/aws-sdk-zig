pub const DeleteObjectRequest = struct {
    /// The path (including the file name) where the object is stored in the
    /// container.
    /// Format: //
    path: []const u8,

    pub const json_field_names = .{
        .path = "Path",
    };
};

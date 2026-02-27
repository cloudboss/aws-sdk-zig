/// Details about notes data.
pub const NotesDataDetails = struct {
    /// The completion data for notes.
    completion: ?[]const u8,

    pub const json_field_names = .{
        .completion = "completion",
    };
};

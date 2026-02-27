/// Contains total number of infected files.
pub const ThreatsDetectedItemCount = struct {
    /// Total number of infected files.
    files: ?i32,

    pub const json_field_names = .{
        .files = "Files",
    };
};

const ReadOptions = @import("read_options.zig").ReadOptions;

/// Formatting options for a TSV file.
pub const TsvOptions = struct {
    /// The file's read options.
    read_options: ?ReadOptions,

    pub const json_field_names = .{
        .read_options = "readOptions",
    };
};

/// Operating System.
pub const OS = struct {
    /// OS full string.
    full_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .full_string = "fullString",
    };
};

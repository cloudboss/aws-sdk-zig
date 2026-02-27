/// Operating System.
pub const OS = struct {
    /// The long name of the Operating System.
    full_string: ?[]const u8,

    pub const json_field_names = .{
        .full_string = "fullString",
    };
};

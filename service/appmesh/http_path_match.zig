/// An object representing the path to match in the request.
pub const HttpPathMatch = struct {
    /// The exact path to match on.
    exact: ?[]const u8,

    /// The regex used to match the path.
    regex: ?[]const u8,

    pub const json_field_names = .{
        .exact = "exact",
        .regex = "regex",
    };
};

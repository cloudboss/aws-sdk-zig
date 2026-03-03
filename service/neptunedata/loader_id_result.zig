/// Contains a list of load IDs.
pub const LoaderIdResult = struct {
    /// A list of load IDs.
    load_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .load_ids = "loadIds",
    };
};

/// A structure that represents a collective constant.
pub const CollectiveConstant = struct {
    /// A list of values for the collective constant.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

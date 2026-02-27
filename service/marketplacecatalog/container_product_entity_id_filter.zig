/// Object that allows filtering on entity id of a container product.
pub const ContainerProductEntityIdFilter = struct {
    /// A string array of unique entity id values to be filtered on.
    value_list: ?[]const []const u8,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

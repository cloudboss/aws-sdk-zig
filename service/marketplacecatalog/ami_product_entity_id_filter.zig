/// Object that allows filtering on entity id of an AMI product.
pub const AmiProductEntityIdFilter = struct {
    /// A string array of unique entity id values to be filtered on.
    value_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .value_list = "ValueList",
    };
};

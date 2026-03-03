/// The information about a dimension.
pub const DimensionDetail = struct {
    /// The identifier of a dimension.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

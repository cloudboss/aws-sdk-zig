/// A split target specifying the CIDR block for the new construct.
pub const SplitConstruct = struct {
    /// The CIDR block for the split construct.
    cidr_block: ?[]const u8 = null,

    pub const json_field_names = .{
        .cidr_block = "cidrBlock",
    };
};

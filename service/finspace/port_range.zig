/// The range of ports the rule applies to.
pub const PortRange = struct {
    /// The first port in the range.
    from: i32 = 0,

    /// The last port in the range.
    to: i32 = 0,

    pub const json_field_names = .{
        .from = "from",
        .to = "to",
    };
};

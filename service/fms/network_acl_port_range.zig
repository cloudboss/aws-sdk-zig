/// TCP or UDP protocols: The range of ports the rule applies to.
pub const NetworkAclPortRange = struct {
    /// The beginning port number of the range.
    from: ?i32,

    /// The ending port number of the range.
    to: ?i32,

    pub const json_field_names = .{
        .from = "From",
        .to = "To",
    };
};

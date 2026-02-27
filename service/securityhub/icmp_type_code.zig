/// An Internet Control Message Protocol (ICMP) type and code.
pub const IcmpTypeCode = struct {
    /// The ICMP code for which to deny or allow access. To deny or allow all codes,
    /// use the
    /// value `-1`.
    code: ?i32,

    /// The ICMP type for which to deny or allow access. To deny or allow all types,
    /// use the
    /// value `-1`.
    type: ?i32,

    pub const json_field_names = .{
        .code = "Code",
        .type = "Type",
    };
};

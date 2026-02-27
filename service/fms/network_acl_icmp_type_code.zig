/// ICMP protocol: The ICMP type and code.
pub const NetworkAclIcmpTypeCode = struct {
    /// ICMP code.
    code: ?i32,

    /// ICMP type.
    type: ?i32,

    pub const json_field_names = .{
        .code = "Code",
        .type = "Type",
    };
};

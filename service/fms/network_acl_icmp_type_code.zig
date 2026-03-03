/// ICMP protocol: The ICMP type and code.
pub const NetworkAclIcmpTypeCode = struct {
    /// ICMP code.
    code: ?i32 = null,

    /// ICMP type.
    @"type": ?i32 = null,

    pub const json_field_names = .{
        .code = "Code",
        .@"type" = "Type",
    };
};

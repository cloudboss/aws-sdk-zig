/// Defines the ICMP protocol that consists of the ICMP type and code.
pub const IcmpTypeCode = struct {
    /// The ICMP code. A value of *-1* means all codes for the specified ICMP type.
    code: i32 = 0,

    /// The ICMP type. A value of *-1* means all types.
    @"type": i32 = 0,

    pub const json_field_names = .{
        .code = "code",
        .@"type" = "type",
    };
};

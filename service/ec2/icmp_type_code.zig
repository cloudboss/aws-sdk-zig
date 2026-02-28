/// Describes the ICMP type and code.
pub const IcmpTypeCode = struct {
    /// The ICMP code. A value of -1 means all codes for the specified ICMP type.
    code: ?i32,

    /// The ICMP type. A value of -1 means all types.
    type: ?i32,
};

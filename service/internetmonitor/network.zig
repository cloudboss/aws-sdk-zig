/// An internet service provider (ISP) or network (ASN) in Amazon CloudWatch
/// Internet Monitor.
pub const Network = struct {
    /// The name of the internet service provider (ISP) or network (ASN).
    as_name: []const u8,

    /// The Autonomous System Number (ASN) of the internet provider or network.
    as_number: i64,

    pub const json_field_names = .{
        .as_name = "ASName",
        .as_number = "ASNumber",
    };
};

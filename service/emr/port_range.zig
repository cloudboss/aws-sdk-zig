/// A list of port ranges that are permitted to allow inbound traffic from all
/// public IP
/// addresses. To specify a single port, use the same value for `MinRange` and
/// `MaxRange`.
pub const PortRange = struct {
    /// The smallest port number in a specified range of port numbers.
    max_range: ?i32 = null,

    /// The smallest port number in a specified range of port numbers.
    min_range: i32,

    pub const json_field_names = .{
        .max_range = "MaxRange",
        .min_range = "MinRange",
    };
};

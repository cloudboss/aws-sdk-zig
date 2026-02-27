/// A unique source IP address that connected to a domain.
pub const UniqueSources = struct {
    /// The number of unique source IP addresses that connected to a domain.
    count: i32 = 0,

    pub const json_field_names = .{
        .count = "Count",
    };
};

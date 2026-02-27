/// Configuration for TXT record-based domain verification method.
pub const TxtMethodConfig = struct {
    /// The name of the TXT record that must be created for domain verification.
    name: []const u8,

    /// The value that must be added to the TXT record for domain verification.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};

/// Contains information about the domain.
pub const DomainDetails = struct {
    /// The domain information for the Amazon Web Services API call.
    domain: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain = "Domain",
    };
};

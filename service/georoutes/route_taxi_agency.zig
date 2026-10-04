/// Details about the taxi agency.
pub const RouteTaxiAgency = struct {
    /// Name of the agency.
    name: []const u8,

    /// URL to the agency's website.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .url = "Url",
    };
};

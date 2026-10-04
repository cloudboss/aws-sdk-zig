/// The properties that are applied when Connect Customer Customer Profiles is
/// used as a
/// destination.
pub const CustomerProfilesDestinationProperties = struct {
    /// The unique name of the Connect Customer Customer Profiles domain.
    domain_name: []const u8,

    /// The object specified in the Connect Customer Customer Profiles flow
    /// destination.
    object_type_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_name = "domainName",
        .object_type_name = "objectTypeName",
    };
};

/// A structure that defines filtering criteria for control implementations. You
/// can use this filter to find controls that are implemented by specific Amazon
/// Web Services services or with specific service identifiers.
pub const ImplementationFilter = struct {
    /// A list of service-specific identifiers that can serve as filters. For
    /// example, you can filter for controls with specific Amazon Web Services
    /// Config Rule IDs or Security Hub Control IDs.
    identifiers: ?[]const []const u8,

    /// A list of implementation types that can serve as filters. For example, you
    /// can filter for controls implemented as Amazon Web Services Config Rules by
    /// specifying AWS::Config::ConfigRule as a type.
    types: ?[]const []const u8,

    pub const json_field_names = .{
        .identifiers = "Identifiers",
        .types = "Types",
    };
};

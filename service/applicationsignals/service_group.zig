/// A structure that represents a logical grouping of services based on shared
/// attributes such as business unit, environment, or entry point.
pub const ServiceGroup = struct {
    /// A unique identifier for this grouping attribute value, used for filtering
    /// and API operations.
    group_identifier: []const u8,

    /// The name of the grouping attribute, such as `BusinessUnit` or `Environment`.
    group_name: []const u8,

    /// The source of the grouping attribute, such as `TAG`, `OTEL`, or `DEFAULT`.
    group_source: []const u8,

    /// The value of the grouping attribute for this service, such as `Payments` or
    /// `Production`.
    group_value: []const u8,

    pub const json_field_names = .{
        .group_identifier = "GroupIdentifier",
        .group_name = "GroupName",
        .group_source = "GroupSource",
        .group_value = "GroupValue",
    };
};

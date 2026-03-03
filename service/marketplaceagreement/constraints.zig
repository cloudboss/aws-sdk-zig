/// Defines limits on how the term can be configured by acceptors.
pub const Constraints = struct {
    /// Determines if buyers are allowed to select multiple dimensions in the rate
    /// card. The possible values are `Allowed` and `Disallowed`. The default value
    /// is `Allowed`.
    multiple_dimension_selection: ?[]const u8 = null,

    /// Determines if acceptors are allowed to configure quantity for each dimension
    /// in rate card. The possible values are `Allowed` and `Disallowed`. The
    /// default value is `Allowed`.
    quantity_configuration: ?[]const u8 = null,

    pub const json_field_names = .{
        .multiple_dimension_selection = "multipleDimensionSelection",
        .quantity_configuration = "quantityConfiguration",
    };
};

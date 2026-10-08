/// A use case describing a scenario where the product can be applied.
pub const UseCase = struct {
    /// A description of the use case.
    description: []const u8,

    /// The human-readable name of the use case.
    display_name: []const u8,

    /// The machine-readable identifier of the use case.
    value: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .value = "value",
    };
};

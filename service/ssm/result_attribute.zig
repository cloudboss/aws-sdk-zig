/// The inventory item result attribute.
pub const ResultAttribute = struct {
    /// Name of the inventory item type. Valid value: `AWS:InstanceInformation`.
    /// Default
    /// Value: `AWS:InstanceInformation`.
    type_name: []const u8,

    pub const json_field_names = .{
        .type_name = "TypeName",
    };
};

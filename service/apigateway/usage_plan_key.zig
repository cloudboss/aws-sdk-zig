/// Represents a usage plan key to identify a plan customer.
pub const UsagePlanKey = struct {
    /// The Id of a usage plan key.
    id: ?[]const u8,

    /// The name of a usage plan key.
    name: ?[]const u8,

    /// The type of a usage plan key. Currently, the valid key type is `API_KEY`.
    @"type": ?[]const u8,

    /// The value of a usage plan key.
    value: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .name = "name",
        .@"type" = "type",
        .value = "value",
    };
};

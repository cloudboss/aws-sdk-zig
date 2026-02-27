/// Additional information provided by the administrator.
pub const UsageInstruction = struct {
    /// The usage instruction type for the value.
    type: ?[]const u8,

    /// The usage instruction value for this type.
    value: ?[]const u8,

    pub const json_field_names = .{
        .type = "Type",
        .value = "Value",
    };
};

/// The definition for a `VisualOptions`.
pub const VisualOptions = struct {
    /// The type for a `VisualOptions`.
    @"type": ?[]const u8,

    pub const json_field_names = .{
        .@"type" = "type",
    };
};

/// Metadata to assign to an Application Manager application.
pub const MetadataValue = struct {
    /// Metadata value to assign to an Application Manager application.
    value: ?[]const u8,

    pub const json_field_names = .{
        .value = "Value",
    };
};

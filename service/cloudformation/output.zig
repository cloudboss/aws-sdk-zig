/// The `Output` data type.
pub const Output = struct {
    /// User defined description associated with the output.
    description: ?[]const u8,

    /// The name of the export associated with the output.
    export_name: ?[]const u8,

    /// The key associated with the output.
    output_key: ?[]const u8,

    /// The value associated with the output.
    output_value: ?[]const u8,
};

const InputSourceType = @import("input_source_type.zig").InputSourceType;

/// Identifies an input source by its identifier and type.
pub const InputSource = struct {
    /// The identifier of the input source.
    identifier: []const u8,

    /// The type of the input source.
    type: InputSourceType,

    pub const json_field_names = .{
        .identifier = "identifier",
        .type = "type",
    };
};

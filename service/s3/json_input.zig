const JSONType = @import("json_type.zig").JSONType;

/// Specifies JSON as object's input serialization format.
pub const JSONInput = struct {
    /// The type of JSON. Valid values: Document, Lines.
    type: ?JSONType = null,
};

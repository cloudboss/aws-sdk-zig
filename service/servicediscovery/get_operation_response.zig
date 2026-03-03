const Operation = @import("operation.zig").Operation;

pub const GetOperationResponse = struct {
    /// A complex type that contains information about the operation.
    operation: ?Operation = null,

    pub const json_field_names = .{
        .operation = "Operation",
    };
};

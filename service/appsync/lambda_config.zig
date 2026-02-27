const InvokeType = @import("invoke_type.zig").InvokeType;

/// The configuration for a Lambda data source.
pub const LambdaConfig = struct {
    /// The invocation type for a Lambda data source.
    invoke_type: ?InvokeType,

    pub const json_field_names = .{
        .invoke_type = "invokeType",
    };
};

const KeyValueStoreAssociations = @import("key_value_store_associations.zig").KeyValueStoreAssociations;
const FunctionRuntime = @import("function_runtime.zig").FunctionRuntime;

/// Contains configuration information about a CloudFront function.
pub const FunctionConfig = struct {
    /// A comment to describe the function.
    comment: []const u8,

    /// The configuration for the key value store associations.
    key_value_store_associations: ?KeyValueStoreAssociations = null,

    /// The function's runtime environment version.
    runtime: FunctionRuntime,
};

const ProtectedQueryOutputConfiguration = @import("protected_query_output_configuration.zig").ProtectedQueryOutputConfiguration;

/// Contains configurations for protected query results.
pub const ProtectedQueryResultConfiguration = struct {
    /// Configuration for protected query results.
    output_configuration: ProtectedQueryOutputConfiguration,

    pub const json_field_names = .{
        .output_configuration = "outputConfiguration",
    };
};

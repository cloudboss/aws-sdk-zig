const ProtectedQueryInputParameters = @import("protected_query_input_parameters.zig").ProtectedQueryInputParameters;

/// Provides the data source that is used to define an input channel.
pub const InputChannelDataSource = union(enum) {
    protected_query_input_parameters: ?ProtectedQueryInputParameters,

    pub const json_field_names = .{
        .protected_query_input_parameters = "protectedQueryInputParameters",
    };
};
